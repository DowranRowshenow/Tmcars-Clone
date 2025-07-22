import 'package:flutter/material.dart';

import '../../../components/no_result.dart';
import '../../../models/article_model.dart';
import '../../../utils/server.dart';
import '../components/article_card.dart';

class ArticlesTab extends StatefulWidget {
  const ArticlesTab({super.key, this.mask});
  final String? mask;
  @override
  State<ArticlesTab> createState() => _ArticlesTabState();
}

class _ArticlesTabState extends State<ArticlesTab> {
  final ScrollController _scrollController = ScrollController();
  final List<Article> _articles = [];
  int _offset = 0;
  bool _isLoading = false;
  bool _hasMore = true;

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
    setState(() => _isLoading = true);

    if (refresh) {
      _offset = 0;
      _articles.clear();
      _hasMore = true;
    }

    try {
      final newArticles = await Server.getArticles(
        offset: _offset,
        mask: widget.mask ?? "",
      );
      setState(() {
        _articles.addAll(newArticles);
        _offset += newArticles.length;
        _hasMore = newArticles.isNotEmpty;
      });
    } catch (e) {
      // Handle error
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
    if (oldWidget.mask != widget.mask) {
      // Mask changed, reload articles
      _loadArticles(refresh: true);
    }
  }

  Future<void> _handleRefresh() async {
    await _loadArticles(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    if (_articles.isEmpty && _isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_articles.isEmpty) {
      return NoResult();
    }
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
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
