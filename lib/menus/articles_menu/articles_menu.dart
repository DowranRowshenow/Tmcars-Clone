import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart' as constants;
import '../../models/article_category_model.dart';
import '../../utils/locale.dart';
import 'tabs/articles_tab.dart';

class NewsMenu extends StatelessWidget {
  const NewsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Directly watch the providers. The UI will rebuild automatically when the
    // data or locale changes. FutureProvider handles the async state.
    final categories = context.watch<List<ArticleCategory>>();
    final locale = context.watch<LocaleManager>().locale;

    // The FutureProvider was configured with `initialData: []`. We can use this
    // to show a loading indicator while the data is being fetched.
    // If an error occurs, the provider will throw it and Flutter will show
    // an error screen in debug mode. For a custom error UI like `NoConnection`,
    // a more advanced error handling setup would be needed.
    if (categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // A helper function to get the correct category name based on locale.
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
              constants.navigate.changeScreen(
                context,
                constants.ScreenState.searchArticles,
              );
            },
            splashRadius: constants.splashRadius,
            icon: const Icon(Icons.search),
            splashColor: Colors.transparent,
          ),
          bottom: TabBar(
            textScaler: TextScaler.linear(constants.tabTextScale),
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: categories
                .map((cat) => Tab(text: getCategoryName(cat)))
                .toList(),
          ),
          actions: [],
        ),
        body: TabBarView(
          // Pass the specific category to each tab so it knows what articles to load.
          // The ArticlesTab will use the category's `code` to fetch the correct articles.
          children:
              categories.map((cat) => ArticlesTab(category: cat)).toList(),
        ),
      ),
    );
  }
}
