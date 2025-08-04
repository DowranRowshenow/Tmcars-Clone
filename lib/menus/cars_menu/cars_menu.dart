import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/should_register_dialog.dart';
import '../../l10n/app_localizations.dart';
import '../../models/car_query_model.dart';
import '../../providers/navigation.dart';
import '../../utils/constants.dart';
import 'components/filter_dialog.dart';
import 'tabs/all_cars_tab.dart';
import 'tabs/categeory_cars_tab.dart';
import 'tabs/selection_cars_tab.dart';

class CarsMenu extends StatefulWidget {
  const CarsMenu({super.key});

  @override
  State<CarsMenu> createState() => _CarsMenuState();
}

class _CarsMenuState extends State<CarsMenu>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    final NavigationManager navigationManager = context
        .read<NavigationManager>();
    final ValueNotifier<CarQuery> carQuery = ValueNotifier<CarQuery>(
      CarQuery(),
    );
    final TabController tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Localizations.of<AppLocalizations>(context, AppLocalizations)!.cars,
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
            color: Colors.white,
            onPressed: () {
              showFilterDialog(
                context: context,
                query: carQuery,
                tabController: tabController,
              );
            },
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
            Tab(text: appLocalizations.cars.toUpperCase()),
            Tab(text: appLocalizations.selected.toUpperCase()),
            Tab(text: appLocalizations.brand.toUpperCase()),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          AllCarsTab(query: carQuery),
          SelectionCarsTab(tabController: tabController, query: carQuery),
          CategoryCarsTab(tabController: tabController, query: carQuery),
        ],
      ),
    );
  }
}
