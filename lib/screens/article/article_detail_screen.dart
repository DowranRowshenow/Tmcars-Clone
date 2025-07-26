import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../components/scroll/glowless_scroll_behavior.dart';
import '../../components/scroll/low_friction_scroll_physics.dart';
import '../../l10n/app_localizations.dart';
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
  double _fabTop = 0;
  bool _fabVisible = true;

  @override
  void initState() {
    super.initState();
    _loadArticle();
    _htmlContentFuture = Server.fetchHtmlContent(
      widget.languageCode == "ru"
          ? widget.article.openUrlRu
          : widget.article.openUrl,
    );
    _fabTop = _expandedHeight - 5;
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadArticle() async {
    articleDetail = await Server.getArticle(widget.article.id);
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

    bool needsUpdate = false;
    if (_fabTop != newTop) {
      _fabTop = newTop;
      needsUpdate = true;
    }
    if (_fabVisible != newVisible) {
      _fabVisible = newVisible;
      needsUpdate = true;
    }
    final bool shouldShowTitle =
        _scrollController.hasClients &&
        _scrollController.offset >= _expandedHeight - kToolbarHeight;
    if (_showTitle != shouldShowTitle) {
      _showTitle = shouldShowTitle;
      needsUpdate = true;
    }
    if (needsUpdate) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final String title = widget.languageCode == "ru"
        ? widget.article.titleRu
        : widget.article.title;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            scrollBehavior: GlowlessScrollBehavior(),
            physics: LowFrictionScrollPhysics(),
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
                                  ? articleDetail?.shareUrlRu ?? ""
                                  : articleDetail?.shareUrl ?? "",
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
                    memCacheHeight: 200,
                    memCacheWidth: 300,
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
                  ),
                ),
              ),
            ],
          ),
          // Floating widget positioned at the bottom of the SliverAppBar
          Positioned(
            top: _fabTop,
            right: 30,
            child: AnimatedScale(
              scale: _fabVisible ? 1.0 : 0.0,
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

  const _ArticleDetailContent({
    required this.articleDetail,
    required this.article,
    required this.languageCode,
    required this.htmlContentFuture,
    required this.appColors,
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
            color: appColors.tagColor2 ?? Constants.blueGrey800,
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
        Container(
          height: 80,
          width: double.infinity,
          color: Colors.grey.withAlpha(70),
        ),
        const SizedBox(height: 10),
        HtmlRenderer(future: htmlContentFuture),
        const SizedBox(height: 10),
        Text(AppLocalizations.of(context)!.tags),
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
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  languageCode == 'ru' ? tag.nameRu : tag.name,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
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
        borderRadius: BorderRadius.circular(5),
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
