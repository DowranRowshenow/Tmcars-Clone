import 'package:flutter/material.dart';

import '../../components/no_connection.dart';
import '../../utils/constants.dart' as constants;
import '../../models/article_category_model.dart';
import 'tabs/articles_tab.dart';

class NewsMenu extends StatefulWidget {
  const NewsMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewsMenuState createState() => _NewsMenuState();
}

class _NewsMenuState extends State<NewsMenu> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleCategory>>(
      future: constants.articleCategory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return NoConnection(onTap: () {});
        }
        final categories = snapshot.data!;
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
                    .map(
                      (cat) => Tab(
                        text:
                            Localizations.localeOf(context).languageCode == 'ru'
                            ? cat.categoryNameRu
                            : cat.categoryName,
                      ),
                    )
                    .toList(),
              ),
              actions: [],
            ),
            body: TabBarView(
              children: categories.map((cat) => ArticlesTab()).toList(),
            ),
          ),
        );
      },
    );
  }
}
