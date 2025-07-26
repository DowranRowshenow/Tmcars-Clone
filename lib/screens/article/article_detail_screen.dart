import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../components/scroll/glowless_scroll_behavior.dart';
import '../../components/scroll/low_friction_scroll_physics.dart';
import '../../l10n/app_localizations.dart';
import '../../models/article_category_model.dart';
import '../../models/article_detail_model.dart';
import '../../models/article_model.dart';
import '../../providers/themes.dart';
import '../../utils/constants.dart';
import '../../utils/server.dart';
import 'components/html_renderer.dart';

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
    setState(() {});
  }

  Future<void> _loadNearestArticles() async {
    nearestArticles = await Server.getNearestArticles(widget.article.id);
    setState(() {});
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
      setState(() {});
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
                ),
                actions: <Widget>[
                  PopupMenuButton<int>(
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
                  background: CachedNetworkImage(
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
                  ),
                ),
              ),
              // This is the body of the screen.
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _ArticleDetailContent(
                    articleDetail: articleDetail,
                    article: widget.article,
                    languageCode: widget.languageCode,
                    htmlContentFuture: _htmlContentFuture,
                    appColors: appColors,
                    tagColor: hexToColor(colorCode ?? "000000"),
                  ),
                ),
              ),
            ],
          ),
          // Floating widget positioned at the bottom of the SliverAppBar
          // Wrapped in AnimatedBuilder to optimize rebuilds
          AnimatedBuilder(
            // Listen to both notifiers to trigger rebuild when either changes
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
                      // TODO: Implement add to favorites
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

// Extracted content widget
class _ArticleDetailContent extends StatelessWidget {
  final ArticleDetail? articleDetail;
  final Article article;
  final String languageCode;
  final Future<String> htmlContentFuture;
  final AppColors appColors;
  final Color tagColor;

  const _ArticleDetailContent({
    required this.articleDetail,
    required this.article,
    required this.languageCode,
    required this.htmlContentFuture,
    required this.appColors,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (articleDetail != null)
          _TagCategoryChip(
            categoryName: languageCode == 'ru'
                ? articleDetail!.categoryNameRu
                : articleDetail!.categoryName,
            color: context.watch<ThemeManager>().isDark()
                ? Colors.blueGrey.shade900
                : tagColor,
          ),
        Text(
          languageCode == 'ru' ? article.titleRu : article.title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _MetaInfoRow(
          article: article,
          articleDetail: articleDetail,
          languageCode: languageCode,
        ),
        const SizedBox(height: 30),
        // Placeholder for an ad or other content
        Container(
          height: 80,
          width: double.infinity,
          color: Colors.grey.withAlpha(70),
        ),
        const SizedBox(height: 10),
        HtmlRenderer(future: htmlContentFuture),
        const SizedBox(height: 10),
        if (articleDetail != null)
          if (articleDetail!.tags.isNotEmpty)
            Text(AppLocalizations.of(context)!.tags.toUpperCase()),
        const SizedBox(height: 10),
        if (articleDetail != null)
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: articleDetail!.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: appColors.tagColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  languageCode == 'ru' ? "#${tag.nameRu}" : "#${tag.name}",
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

// Extracted tag category chip
class _TagCategoryChip extends StatelessWidget {
  final String categoryName;
  final Color color;

  const _TagCategoryChip({required this.categoryName, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(categoryName, style: const TextStyle(color: Colors.white)),
    );
  }
}

// Extracted meta info row
class _MetaInfoRow extends StatelessWidget {
  final Article article;
  final ArticleDetail? articleDetail;
  final String languageCode;

  const _MetaInfoRow({
    required this.article,
    required this.articleDetail,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          languageCode == 'ru' ? article.elapsedTimeRu : article.elapsedTime,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.visibility, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          articleDetail?.viewCount.toString() ?? "",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
