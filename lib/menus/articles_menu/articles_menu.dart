import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/scroll/low_friction_scroll_physics.dart';
import '../../l10n/app_localizations.dart';
import '../../models/article_category_model.dart';
import '../../providers/locale.dart';
import '../../providers/navigation.dart';
import '../../utils/constants.dart';
import 'tabs/articles_tab.dart';

class ArticlesMenu extends StatelessWidget {
  const ArticlesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ArticleCategory> categories = context
        .watch<List<ArticleCategory>>();
    if (categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // It's a good practice to create the list of widgets for TabBarView outside
    // the build method of the TabBarView itself to avoid recreating it on every build.
    // Adding a ValueKey helps Flutter to correctly identify and manage the state
    // of each tab, especially if the list of categories can change dynamically.
    final List<ArticlesTab> articleTabs = categories
        .map(
          (ArticleCategory cat) =>
              ArticlesTab(key: ValueKey<int>(cat.id), category: cat),
        )
        .toList();
    final NavigationManager navigationManager = context
        .read<NavigationManager>();

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Localizations.of<AppLocalizations>(context, AppLocalizations)!.news,
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            splashRadius: Constants.splashRadius,
            onPressed: () =>
                navigationManager.scaffoldKey.currentState?.openDrawer(),
            splashColor: Colors.transparent,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              splashRadius: Constants.splashRadius,
              splashColor: Colors.transparent,
              onPressed: () {
                navigationManager.setScreen(
                  context,
                  ScreenState.searchArticles,
                );
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Consumer<LocaleManager>(
              builder:
                  (
                    BuildContext context,
                    LocaleManager localeManager,
                    Widget? child,
                  ) {
                    return TabBar(
                      padding: const EdgeInsets.all(5),
                      textScaler: const TextScaler.linear(
                        Constants.tabTextScale,
                      ),
                      indicatorColor: Colors.white,
                      isScrollable: true,
                      physics: const LowFrictionScrollPhysics(),
                      tabs: categories
                          .map(
                            (ArticleCategory cat) => Tab(
                              text: cat.getCategoryName(
                                localeManager.locale.languageCode,
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
            ),
          ),
        ),
        body: TabBarView(children: articleTabs),
      ),
    );
  }
}
