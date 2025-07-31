import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/article_category_model.dart';
import '../../providers/locale.dart';
import '../../utils/constants.dart';
import 'tabs/articles_tab.dart';

class ArticlesMenu extends StatelessWidget {
  const ArticlesMenu({super.key});

  String getCategoryName(ArticleCategory category, String languageCode) {
    switch (languageCode) {
      case 'ru':
        return category.categoryNameRu;
      default:
        return category.categoryName; // Fallback to default
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<List<ArticleCategory>>();
    if (categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final locale = context.watch<LocaleManager>().locale;

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: TabBar(
              padding: const EdgeInsets.all(5),
              textScaler: const TextScaler.linear(Constants.tabTextScale),
              indicatorColor: Colors.white,
              isScrollable: true,
              tabs: categories
                  .map(
                    (cat) =>
                        Tab(text: getCategoryName(cat, locale.languageCode)),
                  )
                  .toList(),
            ),
          ),
        ),
        body: TabBarView(
          children: categories
              .map((cat) => ArticlesTab(category: cat))
              .toList(),
        ),
      ),
    );
  }
}
