import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../models/article_category_model.dart';
import '../../providers/locale.dart';
import '../../providers/navigation.dart';
import 'tabs/articles_tab.dart';

class ArticlesMenu extends StatelessWidget {
  const ArticlesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<List<ArticleCategory>>();
    if (categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final locale = context.watch<LocaleManager>().locale;

    String getCategoryName(ArticleCategory category) {
      switch (locale.languageCode) {
        case 'ru':
          return category.categoryNameRu;
        default:
          return category.categoryName; // Fallback to default
      }
    }

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          leading: IconButton(
            onPressed: () {
              context.read<NavigationManager>().setScreen(
                context,
                ScreenState.searchArticles,
              );
            },
            splashRadius: Constants.splashRadius,
            icon: const Icon(Icons.search),
            splashColor: Colors.transparent,
          ),
          bottom: TabBar(
            textScaler: const TextScaler.linear(Constants.tabTextScale),
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: categories
                .map((cat) => Tab(text: getCategoryName(cat)))
                .toList(),
          ),
          actions: const [],
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
