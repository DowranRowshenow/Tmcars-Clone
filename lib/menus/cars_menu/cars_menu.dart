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

class CarsMenu extends StatelessWidget {
  const CarsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    final NavigationManager navigationManager = context
        .read<NavigationManager>();
    final ValueNotifier<CarQuery> carQuery = ValueNotifier<CarQuery>(
      CarQuery(),
    );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                showFilterDialog(context: context, query: carQuery);
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
            textScaler: const TextScaler.linear(Constants.tabTextScale),
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text: appLocalizations.cars.toUpperCase()),
              Tab(text: appLocalizations.selected.toUpperCase()),
              Tab(text: appLocalizations.category.toUpperCase()),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AllCarsTab(query: carQuery),
            const SelectionCarsTab(),
            const CategoryCarsTab(),
          ],
        ),
      ),
    );
  }
}
