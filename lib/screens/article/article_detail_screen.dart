// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../components/app_bar_image.dart';
import '../../components/back_icon_button.dart';
import '../../components/should_register_dialog.dart';
import '../../components/scroll/glowless_scroll_behavior.dart';
import '../../components/scroll/low_friction_scroll_physics.dart';
import '../../l10n/app_localizations.dart';
import '../../models/article_category_model.dart';
import '../../models/article_detail_model.dart';
import '../../models/article_model.dart';
import '../../providers/navigation.dart';
import '../../providers/themes.dart';
import '../../utils/constants.dart';
import '../../utils/server.dart';
import 'components/article_detail_content.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({
    super.key,
    required this.article,
    required this.languageCode,
  });
  final Article article;
  final String languageCode;

  @override
  // ignore: library_private_types_in_public_api
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  ArticleDetail? articleDetail;
  static const double _expandedHeight = 250.0;
  static const double _offset = 10.0;
  late Future<String> _htmlContentFuture;
  List<Article>? nearestArticles;
  // Use ValueNotifiers for FAB position and visibility
  final ValueNotifier<double> _fabTopNotifier = ValueNotifier<double>(0);
  final ValueNotifier<bool> _fabVisibleNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _showTitleNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _loadArticle();
    _loadNearestArticles();
    _htmlContentFuture = Server.fetchHtmlContent(
      widget.languageCode == "ru"
          ? widget.article.openUrlRu
          : widget.article.openUrl,
    );
    // Initialize ValueNotifiers with their initial values
    _fabTopNotifier.value = _expandedHeight - _offset;
    _fabVisibleNotifier.value = true;
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color.fromARGB(40, 0, 0, 0)),
    );
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _fabTopNotifier.dispose();
    _fabVisibleNotifier.dispose();
    _showTitleNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadArticle() async {
    articleDetail = await Server.getArticle(widget.article.id);
    if (mounted) setState(() {});
  }

  Future<void> _loadNearestArticles() async {
    nearestArticles = await Server.getNearestArticles(widget.article.id);
    if (mounted) setState(() {});
  }

  void _onScroll() {
    final offset = _scrollController.hasClients
        ? _scrollController.offset
        : 0.0;
    double newTop = (_expandedHeight - _offset) - offset;
    if (newTop < kToolbarHeight) newTop = kToolbarHeight;
    bool newVisible = newTop > kToolbarHeight + 1;

    if (_fabTopNotifier.value != newTop) {
      _fabTopNotifier.value = newTop;
    }
    if (_fabVisibleNotifier.value != newVisible) {
      _fabVisibleNotifier.value = newVisible;
    }

    final bool shouldShowTitle =
        _scrollController.hasClients &&
        _scrollController.offset >= _expandedHeight - kToolbarHeight;
    if (_showTitleNotifier.value != shouldShowTitle) {
      _showTitleNotifier.value = shouldShowTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final String title = widget.languageCode == "ru"
        ? widget.article.titleRu
        : widget.article.title;
    final allCategories = context.watch<List<ArticleCategory>>();
    final category = allCategories.firstWhereOrNull(
      (c) => c.categoryName == widget.article.categoryName,
    );
    final colorCode = category?.colorCode ?? "000000";

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            scrollBehavior: GlowlessScrollBehavior(),
            physics: const LowFrictionScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: _expandedHeight,
                pinned: true,
                floating: false,
                snap: false,
                title: ValueListenableBuilder<bool>(
                  valueListenable: _showTitleNotifier,
                  builder: (context, showTitle, child) {
                    return AnimatedOpacity(
                      opacity: showTitle ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: child,
                    );
                  },
                  child: Text(title),
                ),
                leading: buildBackIconButton(context),
                actions: <Widget>[
                  PopupMenuButton<int>(
                    tooltip: "",
                    menuPadding: const EdgeInsets.all(0),
                    color: appColors.themedSurface,
                    splashRadius: Constants.splashRadius,
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onSelected: (int value) {
                      switch (value) {
                        case 0:
                          SharePlus.instance.share(
                            ShareParams(
                              text: widget.languageCode == 'ru'
                                  ? articleDetail?.shareSiteUrlRu ?? ""
                                  : articleDetail?.shareSiteUrl ?? "",
                            ),
                          );
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<int>>[
                          PopupMenuItem<int>(
                            value: 0,
                            child: Text(
                              AppLocalizations.of(context)!.shareLink,
                            ),
                          ),
                        ],
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: GestureDetector(
                    onTap: () {
                      context.read<NavigationManager>().setScreen(
                        context,
                        ScreenState.imageView,
                        imageUrls: articleDetail?.getImageUrls(),
                      );
                    },
                    child: articleDetail == null
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : AppBarImage(
                            imageUrls: articleDetail!.getImageUrls(
                              isThumbnail: true,
                            ),
                          ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ArticleDetailContent(
                    articleDetail: articleDetail,
                    article: widget.article,
                    languageCode: widget.languageCode,
                    htmlContentFuture: _htmlContentFuture,
                    appColors: appColors,
                    tagColor: AppColors.hexToColor(colorCode),
                    nearestArticles: nearestArticles ?? [],
                  ),
                ),
              ),
            ],
          ),
          AnimatedBuilder(
            animation: Listenable.merge([_fabTopNotifier, _fabVisibleNotifier]),
            builder: (context, child) {
              return Positioned(
                top: _fabTopNotifier.value,
                right: 30,
                child: AnimatedScale(
                  scale: _fabVisibleNotifier.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: FloatingActionButton(
                    onPressed: Constants.isRegistered
                        ? null
                        : () => shouldRegisterDialog(context: context),
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.thumb_up_outlined,
                      color: _fabVisibleNotifier.value
                          ? Colors.blueGrey
                          : Colors.transparent,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
