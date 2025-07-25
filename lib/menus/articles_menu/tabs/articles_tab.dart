import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../components/no_connection.dart';
import '../../../components/no_result.dart';
import '../../../models/article_category_model.dart';
import '../../../models/article_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/server.dart';
import '../../../utils/storage.dart';
import '../components/article_card.dart';

class ArticlesTab extends StatefulWidget {
  const ArticlesTab({super.key, this.category, this.mask, this.tags});
  final String? mask;
  final String? tags;
  final ArticleCategory? category;
  @override
  State<ArticlesTab> createState() => _ArticlesTabState();
}

class _ArticlesTabState extends State<ArticlesTab> {
  final ScrollController _scrollController = ScrollController();
  List<Article> _articles = [];
  int _offset = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController
        .dispose(); // It's good practice to remove the listener before disposing.
    super.dispose();
  }

  Future<void> _initializeData() async {
    // First, try to load articles from local storage to show data quickly.
    final cachedArticles = await Storage().getArticlesByCategory(
      widget.category?.id ?? 0,
    );
    if (mounted && cachedArticles.isNotEmpty) {
      setState(() {
        _articles = cachedArticles;
      });
    }

    // Then, fetch the latest articles from the server.
    // This will either populate the list for the first time or
    // update the existing cached list.
    await _loadArticles(refresh: true);
  }

  Future<void> _loadArticles({bool refresh = false}) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
      if (refresh) {
        _hasError = false; // Reset error state on refresh
      }
    });

    if (refresh) {
      _offset = 0;
      _hasMore = true;
    }

    try {
      final newArticles = await Server.getArticles(
        offset: _offset,
        mask: widget.mask ?? "",
        tags: widget.tags ?? "",
        categoryCode: widget.category?.code ?? "",
        categoryId: widget.category?.id ?? 0,
      );
      if (mounted) {
        setState(() {
          if (refresh) {
            _articles = newArticles;
          } else {
            _articles.addAll(newArticles);
          }
          _offset = _articles.length;
          _hasMore = newArticles.isNotEmpty;
          _hasError = false; // Data loaded successfully
        });
        // After updating the UI, save the complete list to the cache.
        if (newArticles.isNotEmpty) {
          await _saveArticlesToCache();
        }
      }
    } catch (e) {
      // If an error occurs, set the error flag.
      if (mounted) {
        setState(() => _hasError = true);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveArticlesToCache() async {
    if (widget.category?.id == null) return;
    // We convert the list of Article objects back to a JSON string to save it.
    final articlesJson = jsonEncode(_articles.map((a) => a.toJson()).toList());
    await Storage().setArticlesByCategory(
      articlesJson,
      widget.category?.id ?? 0,
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _loadArticles();
    }
  }

  @override
  void didUpdateWidget(covariant ArticlesTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the direct mask or the category has changed, reload the articles.
    if (oldWidget.mask != widget.mask ||
        oldWidget.category?.id != widget.category?.id) {
      _loadArticles(refresh: true);
    }
  }

  Future<void> _handleRefresh() async {
    await _loadArticles(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    // If there's an error and we have no articles, show the NoConnection widget.
    if (_hasError && _articles.isEmpty) {
      return NoConnection(onTap: _handleRefresh);
    }

    // Show a loading indicator on initial load.
    if (_articles.isEmpty && _isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // If loading is finished and there are no articles, show NoResult.
    if (_articles.isEmpty && !_isLoading) {
      return const NoResult();
    }

    // Otherwise, display the list of articles.
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        itemExtent: Constants.articleItemExtent,
        controller: _scrollController,
        itemCount: _articles.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _articles.length) {
            return ArticleCard(article: _articles[index]);
          } else {
            // Show loading indicator at the bottom
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
