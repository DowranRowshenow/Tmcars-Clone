import 'package:flutter/material.dart';

import '../../../components/no_connection.dart';
import '../../../components/no_result.dart';
import '../../../models/article_category_model.dart';
import '../../../models/article_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/server.dart';
import '../components/article_card.dart';

class ArticlesTab extends StatefulWidget {
  const ArticlesTab({super.key, this.category, this.mask});
  final String? mask;
  final ArticleCategory? category;
  @override
  State<ArticlesTab> createState() => _ArticlesTabState();
}

class _ArticlesTabState extends State<ArticlesTab> {
  final ScrollController _scrollController = ScrollController();
  final List<Article> _articles = [];
  int _offset = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadArticles();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      _articles.clear();
      _hasMore = true;
    }

    try {
      // Use the direct mask if provided, otherwise use the category's code.
      final String effectiveMask = widget.mask ?? widget.category?.code ?? "";

      final newArticles = await Server.getArticles(
        offset: _offset,
        mask: effectiveMask,
      );
      if (mounted) {
        setState(() {
          _articles.addAll(newArticles);
          _offset += newArticles.length;
          _hasMore = newArticles.isNotEmpty;
          _hasError = false; // Data loaded successfully
        });
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
