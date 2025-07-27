import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../components/placeholder_image.dart';
import '../../components/should_register_dialog.dart';
import '../../../components/scroll/glowless_scroll_behavior.dart';
import '../../components/scroll/low_friction_scroll_physics.dart';
import '../../l10n/app_localizations.dart';
import '../../models/article_category_model.dart';
import '../../models/article_detail_model.dart';
import '../../models/article_model.dart';
import '../../providers/themes.dart';
import '../../providers/traffic.dart';
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
  bool _showTitle = false;
  ArticleDetail? articleDetail;
  static const double _expandedHeight = 250.0;
  late Future<String> _htmlContentFuture;
  List<Article>? nearestArticles;
  String? colorCode;
  List<ArticleCategory>? articleCategories;
  // Use ValueNotifiers for FAB position and visibility
  final ValueNotifier<double> _fabTopNotifier = ValueNotifier<double>(0);
  final ValueNotifier<bool> _fabVisibleNotifier = ValueNotifier<bool>(true);

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
    _fabTopNotifier.value = _expandedHeight - 5;
    _fabVisibleNotifier.value = true;
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _fabTopNotifier.dispose(); // Dispose notifiers to prevent memory leaks
    _fabVisibleNotifier.dispose();
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
    double newTop = (_expandedHeight - 5) - offset;
    // Prevent it from going above the appbar
    if (newTop < kToolbarHeight) newTop = kToolbarHeight;
    bool newVisible = newTop > kToolbarHeight + 1;

    // Update ValueNotifiers only if values have changed
    if (_fabTopNotifier.value != newTop) {
      _fabTopNotifier.value = newTop;
    }
    if (_fabVisibleNotifier.value != newVisible) {
      _fabVisibleNotifier.value = newVisible;
    }

    // _showTitle still requires setState as it affects the AppBar title,
    // which is part of the main build method and not wrapped in AnimatedBuilder.
    final bool shouldShowTitle =
        _scrollController.hasClients &&
        _scrollController.offset >= _expandedHeight - kToolbarHeight;
    if (_showTitle != shouldShowTitle) {
      _showTitle = shouldShowTitle;
      if (mounted) setState(() {});
    }
  }

  Color hexToColor(String hexCode) {
    String colorString = hexCode.replaceAll("#", ""); // Remove '#'
    colorString = colorString.replaceAll("0x", ""); // Remove '0x'

    if (colorString.length == 6) {
      colorString = "FF$colorString"; // Add full opacity if missing
    }

    // Parse the hexadecimal string to an integer
    return Color(int.parse(colorString, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final String title = widget.languageCode == "ru"
        ? widget.article.titleRu
        : widget.article.title;
    if (articleCategories == null) {
      articleCategories = context.watch<List<ArticleCategory>>();
      for (int i = 0; i < articleCategories!.length; i++) {
        if (articleCategories![i].categoryName == widget.article.categoryName) {
          colorCode = articleCategories![i].colorCode;
          break;
        }
      }
    }

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
                title: AnimatedOpacity(
                  opacity: _showTitle ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(title),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  splashRadius: Constants.splashRadius,
                  splashColor: Colors.transparent,
                ),
                actions: <Widget>[
                  PopupMenuButton<int>(
                    tooltip: "",
                    menuPadding: const EdgeInsets.all(0),
                    color: appColors.themedSurface,
                    splashRadius: Constants.splashRadius,
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
                  background:
                      context.watch<TrafficManager>().getTrafficMode == 0
                      ? CachedNetworkImage(
                          imageUrl: widget.article.img,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: appColors.tileThemeColor,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fadeInDuration: const Duration(milliseconds: 200),
                          memCacheHeight: 400,
                          memCacheWidth: 600,
                        )
                      : buildImagePlaceholder(context),
                ),
              ),
              // This is the body of the screen.
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ArticleDetailContent(
                    articleDetail: articleDetail,
                    article: widget.article,
                    languageCode: widget.languageCode,
                    htmlContentFuture: _htmlContentFuture,
                    appColors: appColors,
                    tagColor: hexToColor(colorCode ?? "000000"),
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
                    onPressed: () {
                      Constants.isRegistered
                          ? const SizedBox()
                          : shouldRegisterDialog(context: context);
                    },
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.thumb_up_outlined,
                      color: Colors.blueGrey,
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
