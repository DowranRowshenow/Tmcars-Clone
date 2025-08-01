// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../components/app_bar_image.dart';
import '../../components/back_icon_button.dart';
import '../../components/scroll/glowless_scroll_behavior.dart';
import '../../components/scroll/low_friction_scroll_physics.dart';
import '../../components/should_register_dialog.dart';
import '../../l10n/app_localizations.dart';
import '../../models/article_category_model.dart';
import '../../models/article_detail_model.dart';
import '../../models/article_model.dart';
import '../../providers/navigation.dart';
import '../../providers/themes.dart';
import '../../utils/constants.dart';
import '../../utils/server.dart';
import 'components/article_detail_content.dart';

/// Represents the scroll state for the article detail screen
class ScrollState {
  final double fabTop;
  final bool fabVisible;
  final bool showTitle;

  const ScrollState({
    required this.fabTop,
    required this.fabVisible,
    required this.showTitle,
  });

  static const double expandedHeight = 250.0;
  static const double offset = 5.0;

  static const ScrollState initial = ScrollState(
    fabTop: expandedHeight - offset,
    fabVisible: true,
    showTitle: false,
  );

  ScrollState copyWith({double? fabTop, bool? fabVisible, bool? showTitle}) {
    return ScrollState(
      fabTop: fabTop ?? this.fabTop,
      fabVisible: fabVisible ?? this.fabVisible,
      showTitle: showTitle ?? this.showTitle,
    );
  }
}

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
  final ValueNotifier<ArticleDetail?> _articleDetailNotifier =
      ValueNotifier<ArticleDetail?>(null);
  final ValueNotifier<List<Article>?> _nearestArticlesNotifier =
      ValueNotifier<List<Article>?>(null);

  late Future<String> _htmlContentFuture;

  // Combine all scroll-related states into a single notifier
  final ValueNotifier<ScrollState> _scrollStateNotifier =
      ValueNotifier<ScrollState>(ScrollState.initial);

  // Cache computed values
  String? _cachedTitle;
  String? _cachedColorCode;

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
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _scrollStateNotifier.dispose();
    _articleDetailNotifier.dispose();
    _nearestArticlesNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadArticle() async {
    final ArticleDetail? articleDetail = await Server.getArticle(
      widget.article.id,
    );
    _articleDetailNotifier.value = articleDetail;
  }

  Future<void> _loadNearestArticles() async {
    final List<Article> nearestArticles = await Server.getNearestArticles(
      widget.article.id,
    );
    if (mounted) _nearestArticlesNotifier.value = nearestArticles;
  }

  void _onScroll() {
    final double offset = _scrollController.hasClients
        ? _scrollController.offset
        : 0.0;

    double newTop = (ScrollState.expandedHeight - ScrollState.offset) - offset;
    if (newTop < kToolbarHeight) newTop = kToolbarHeight;
    bool newVisible = newTop > kToolbarHeight + 1;

    final bool shouldShowTitle =
        _scrollController.hasClients &&
        _scrollController.offset >= ScrollState.expandedHeight - kToolbarHeight;

    final ScrollState newState = _scrollStateNotifier.value.copyWith(
      fabTop: newTop,
      fabVisible: newVisible,
      showTitle: shouldShowTitle,
    );

    if (_scrollStateNotifier.value != newState) {
      _scrollStateNotifier.value = newState;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    // Cache computed values to avoid recalculation on every build
    _cachedTitle ??= widget.languageCode == "ru"
        ? widget.article.titleRu
        : widget.article.title;

    final List<ArticleCategory> allCategories = context
        .watch<List<ArticleCategory>>();
    final ArticleCategory? category = allCategories.firstWhereOrNull(
      (ArticleCategory c) => c.categoryName == widget.article.categoryName,
    );
    _cachedColorCode ??= category?.colorCode ?? "000000";

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            scrollBehavior: GlowlessScrollBehavior(),
            physics: const LowFrictionScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: ScrollState.expandedHeight,
                pinned: true,
                floating: false,
                snap: false,
                title: ValueListenableBuilder<ScrollState>(
                  valueListenable: _scrollStateNotifier,
                  builder:
                      (
                        BuildContext context,
                        ScrollState scrollState,
                        Widget? child,
                      ) {
                        return AnimatedOpacity(
                          opacity: scrollState.showTitle ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: Text(_cachedTitle!),
                        );
                      },
                ),
                leading: buildBackIconButton(context),
                actions: <Widget>[
                  ValueListenableBuilder<ScrollState>(
                    valueListenable: _scrollStateNotifier,
                    builder:
                        (
                          BuildContext context,
                          ScrollState scrollState,
                          Widget? child,
                        ) {
                          return AnimatedOpacity(
                            opacity: scrollState.showTitle ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: IconButton(
                              splashColor: Colors.transparent,
                              splashRadius: Constants.splashRadius,
                              icon: const Icon(Icons.thumb_up_outlined),
                              onPressed: () =>
                                  shouldRegisterDialog(context: context),
                            ),
                          );
                        },
                  ),
                  ValueListenableBuilder<ArticleDetail?>(
                    valueListenable: _articleDetailNotifier,
                    builder:
                        (
                          BuildContext context,
                          ArticleDetail? articleDetail,
                          Widget? child,
                        ) {
                          return PopupMenuButton<int>(
                            tooltip: "",
                            menuPadding: const EdgeInsets.all(0),
                            color: appColors.themedSurface,
                            splashRadius: Constants.splashRadius,
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                            ),
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<int>>[
                                  PopupMenuItem<int>(
                                    value: 0,
                                    child: Text(
                                      AppLocalizations.of(context)!.shareLink,
                                    ),
                                  ),
                                ],
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
                          );
                        },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: ValueListenableBuilder<ArticleDetail?>(
                    valueListenable: _articleDetailNotifier,
                    builder:
                        (
                          BuildContext context,
                          ArticleDetail? articleDetail,
                          Widget? child,
                        ) {
                          return articleDetail == null
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : AppBarImage(
                                  onTapVideo: () {
                                    context.read<NavigationManager>().setScreen(
                                      context,
                                      ScreenState.videoView,
                                      video: articleDetail.mainVideo,
                                    );
                                  },
                                  onTapImage: () {
                                    context.read<NavigationManager>().setScreen(
                                      context,
                                      ScreenState.imageView,
                                      imageUrls: articleDetail.getImageUrls(),
                                    );
                                  },
                                  mainVideo: articleDetail.mainVideo,
                                  imageUrls: articleDetail.getImageUrls(
                                    isThumbnail: true,
                                  ),
                                );
                        },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ValueListenableBuilder<List<Article>?>(
                    valueListenable: _nearestArticlesNotifier,
                    builder:
                        (
                          BuildContext context,
                          List<Article>? nearestArticles,
                          Widget? child,
                        ) {
                          return ValueListenableBuilder<ArticleDetail?>(
                            valueListenable: _articleDetailNotifier,
                            builder:
                                (
                                  BuildContext context,
                                  ArticleDetail? articleDetail,
                                  Widget? child,
                                ) {
                                  return ArticleDetailContent(
                                    articleDetail: articleDetail,
                                    article: widget.article,
                                    languageCode: widget.languageCode,
                                    htmlContentFuture: _htmlContentFuture,
                                    appColors: appColors,
                                    tagColor: AppColors.hexToColor(
                                      _cachedColorCode!,
                                    ),
                                    nearestArticles:
                                        nearestArticles ?? <Article>[],
                                  );
                                },
                          );
                        },
                  ),
                ),
              ),
            ],
          ),
          ValueListenableBuilder<ScrollState>(
            valueListenable: _scrollStateNotifier,
            builder:
                (BuildContext context, ScrollState scrollState, Widget? child) {
                  return Positioned(
                    top: scrollState.fabTop,
                    right: 30,
                    child: AnimatedScale(
                      scale: scrollState.fabVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      child: FloatingActionButton(
                        onPressed: Constants.isRegistered
                            ? null
                            : () => shouldRegisterDialog(context: context),
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.thumb_up_outlined,
                          color: scrollState.fabVisible
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
