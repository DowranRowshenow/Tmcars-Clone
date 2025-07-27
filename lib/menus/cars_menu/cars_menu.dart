import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/constants.dart';
import 'tabs/all_cars_tab.dart';
import 'tabs/categeory_cars_tab.dart';
import 'tabs/selection_cars_tab.dart';

class CarsMenu extends StatelessWidget {
  const CarsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          leading: const SizedBox(),
          bottom: TabBar(
            textScaler: const TextScaler.linear(Constants.tabTextScale),
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: appLocalizations.cars.toUpperCase()),
              Tab(text: appLocalizations.selected.toUpperCase()),
              Tab(text: appLocalizations.category.toUpperCase()),
            ],
          ),
        ),
        body: const TabBarView(
          children: [AllCarsTab(), SelectionCarsTab(), CategoryCarsTab()],
        ),
      ),
    );
  }
}
