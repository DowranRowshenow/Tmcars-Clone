import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/constants.dart';
import 'tabs/all_car_parts_tab.dart';
import 'tabs/category_car_parth_tab.dart';
import 'tabs/selection_car_parts_tab.dart';

class CarPartsMenu extends StatelessWidget {
  const CarPartsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
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
          children: [
            AllCarPartsTab(),
            SelectionCarPartsTab(),
            CategoryCarPartsTab(),
          ],
        ),
      ),
    );
  }
}
