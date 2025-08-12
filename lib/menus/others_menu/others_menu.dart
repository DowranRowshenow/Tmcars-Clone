import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/should_register_dialog.dart';
import '../../l10n/app_localizations.dart';
import '../../models/car_query_model.dart';
import '../../providers/navigation.dart';
import '../../utils/constants.dart';
import 'tabs/all_others_tab.dart';
import 'tabs/category_others_tab.dart';
import 'tabs/selection_others_tab.dart';

class OthersMenu extends StatefulWidget {
  const OthersMenu({super.key});

  @override
  State<OthersMenu> createState() => _OthersMenuState();
}

class _OthersMenuState extends State<OthersMenu> with TickerProviderStateMixin {
  final TextEditingController searchBarController = TextEditingController();
  late TabController tabController;
  final PageController _pageController = PageController();
  final ValueNotifier<CarQuery> carQuery = ValueNotifier<CarQuery>(CarQuery());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    searchBarController.dispose();
    carQuery.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NavigationManager navigationManager = context
        .read<NavigationManager>();
    final AppLocalizations appLocalizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.others),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          splashRadius: Constants.splashRadius,
          onPressed: () =>
              navigationManager.scaffoldKey.currentState?.openDrawer(),
          splashColor: Colors.transparent,
        ),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            onPressed: () {},
            splashRadius: Constants.splashRadius,
            icon: const Icon(Icons.sort),
            splashColor: Colors.transparent, // Consistent splash behavior
          ),
          IconButton(
            color: Colors.white,
            onPressed: () => shouldRegisterDialog(context: context),
            splashRadius: Constants.splashRadius,
            icon: const Icon(Icons.star),
            splashColor: Colors.transparent, // Consistent splash behavior
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          textScaler: const TextScaler.linear(Constants.tabTextScale),
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(text: appLocalizations.all.toUpperCase()),
            Tab(text: appLocalizations.selected.toUpperCase()),
            Tab(text: appLocalizations.category.toUpperCase()),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          AllOthersTab(
            query: carQuery,
            searchBarController: searchBarController,
          ),
          SelectionOthersTab(
            tabController: tabController,
            query: carQuery,
            searchBarController: searchBarController,
          ),
          CategoryOthersTab(
            tabController: tabController,
            query: carQuery,
            searchBarController: searchBarController,
          ),
        ],
      ),
    );
  }
}
