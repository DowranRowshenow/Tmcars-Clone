import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/fab_scroller.dart';
import '../../../components/no_connection.dart';
import '../../../components/no_result.dart';
import '../../../models/article_category_model.dart';
import '../../../models/article_model.dart';
import '../../../providers/locale.dart';
import '../../../providers/themes.dart';
import '../../../providers/traffic.dart';
import '../../../utils/articles_controller.dart';
import '../../../utils/constants.dart';
import '../../../utils/server.dart';
import '../../../utils/storage.dart';
import '../components/article_card.dart';

class ArticlesTab extends StatefulWidget {
  const ArticlesTab({
    super.key,
    this.category,
    this.mask,
    this.tags,
    this.isCacheEnabled = true,
  });
  final ValueNotifier<String>? mask;
  final String? tags;
  final ArticleCategory? category;
  final bool isCacheEnabled;
  @override
  State<ArticlesTab> createState() => _ArticlesTabState();
}

class _ArticlesTabState extends State<ArticlesTab> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<List<Article>> _articles = ValueNotifier<List<Article>>(
    <Article>[],
  );
  final double _imageHeight = 90.0;
  final double _imageMaxWidth = 260.0;
  final AriclesLoadingController _articlesLoadingController =
      AriclesLoadingController();
  int _offset = 0;
  String query = "";

  @override
  void initState() {
    super.initState();
    _initializeData();
    widget.mask?.addListener(_onMaskChange);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _articles.dispose();
    _scrollController.removeListener(_onScroll);
    widget.mask?.removeListener(_onMaskChange);
    _scrollController.dispose();
    _articlesLoadingController.dispose();
    super.dispose();
  }

  void _onMaskChange() {
    query = "";
    if (widget.mask != null && widget.mask!.value.isNotEmpty) {
      query = widget.mask!.value;
    }
    _loadArticles(refresh: true);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_articlesLoadingController.isLoading.value &&
        _articlesLoadingController.hasMore.value) {
      _loadArticles();
    }
  }

  Future<void> _initializeData() async {
    // First, try to load articles from local storage to show data quickly.
    if (widget.isCacheEnabled) {
      final List<Article> cachedArticles = await Storage.instance
          .getArticlesByCategory(widget.category?.id ?? 0);
      if (mounted && cachedArticles.isNotEmpty) {
        _articles.value = cachedArticles;
      }
    }

    await _loadArticles(refresh: true);
  }

  Future<void> _loadArticles({bool refresh = false}) async {
    if (_articlesLoadingController.isLoading.value || !mounted) return;
    _articlesLoadingController.isLoading.value = true;
    if (refresh) {
      _articlesLoadingController.hasError.value = false;
      _articlesLoadingController.hasMore.value = true;
      _offset = 0;
    }

    final List<Article>? newArticles = await Server.getArticles(
      offset: _offset,
      mask: query,
      tags: widget.tags ?? "",
      categoryCode: widget.category?.code ?? "",
      categoryId: widget.category?.id ?? 0,
    );
    if (!mounted) return;

    if (newArticles == null) {
      _articlesLoadingController.hasError.value = true;
    } else {
      if (refresh) {
        _articles.value = newArticles;
      } else {
        _articles.value = <Article>[..._articles.value, ...newArticles];
      }
      _offset = _articles.value.length;
      _articlesLoadingController.hasMore.value = newArticles.isNotEmpty;
      _articlesLoadingController.hasError.value = false;
      if (newArticles.isNotEmpty && widget.isCacheEnabled) {
        Storage.instance.cacheArticles(widget.category?.id, _articles.value);
      }
    }
    _articlesLoadingController.isLoading.value = false;
  }

  @override
  void didUpdateWidget(covariant ArticlesTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the direct mask or the category has changed, reload the articles.
    /*
    if (oldWidget.mask != widget.mask ||
        oldWidget.category?.id != widget.category?.id) {
      _loadArticles(refresh: true);
    }
    */
  }

  Future<void> _handleRefresh() async {
    await _loadArticles(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    /*
    // If there's an error and we have no articles, show the NoConnection widget.
    if ((_articlesLoadingController.hasError.value) &&
        (!widget.isCacheEnabled || _articles.value.isEmpty)) {
      return NoConnection(onTap: _handleRefresh);
    }
    // Show a loading indicator on initial load.
    else if (_articlesLoadingController.isLoading.value &&
        (!widget.isCacheEnabled || _articles.value.isEmpty) &&
        query != "") {
      return const Center(child: CircularProgressIndicator());
    }
    // If loading is finished and there are no articles, show NoResult.
    else if (_articles.value.isEmpty &&
        !_articlesLoadingController.isLoading.value) {
      return const NoResult();
    }*/
    final bool isStandardTraffic = context.watch<TrafficManager>().isStandart();
    final double width = (MediaQuery.of(context).size.width * 0.4).clamp(
      _imageHeight,
      _imageMaxWidth,
    );
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final Locale locale = context.watch<LocaleManager>().locale;

    // Otherwise, display the list of articles.
    return Scaffold(
      floatingActionButton: FabScroller(scrollController: _scrollController),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ValueListenableBuilder<List<Article>>(
          valueListenable: _articles,
          builder: (BuildContext context, List<Article> value, Widget? child) {
            if ((_articlesLoadingController.hasError.value) &&
                (!widget.isCacheEnabled || _articles.value.isEmpty)) {
              return NoConnection(onTap: _handleRefresh);
            }
            // Show a loading indicator on initial load.
            else if ((_articlesLoadingController.isLoading.value &&
                    (_articles.value.isEmpty || query != "")) ||
                (widget.isCacheEnabled && _articles.value.isEmpty)) {
              return const Center(child: CircularProgressIndicator());
            }
            // If loading is finished and there are no articles, show NoResult.
            else if (_articles.value.isEmpty &&
                !_articlesLoadingController.isLoading.value) {
              return const NoResult();
            }
            return ListView.builder(
              itemExtent: Constants.articleItemExtent,
              controller: _scrollController,
              shrinkWrap: true,
              itemCount:
                  _articles.value.length +
                  (_articlesLoadingController.hasMore.value ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index < _articles.value.length) {
                  return ArticleCard(
                    key: ValueKey<int>(_articles.value[index].id),
                    article: _articles.value[index],
                    isStandardTraffic: isStandardTraffic,
                    imageWidth: width,
                    dividerColor: appColors.dividerColor!,
                    textHintThemeColor: appColors.textHintThemeColor!,
                    locale: locale,
                  );
                } else {
                  // Show loading indicator at the bottom
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
