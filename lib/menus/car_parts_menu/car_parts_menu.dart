import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/constants.dart';
import 'tabs/all_car_parts_tab.dart';
import 'tabs/selection_car_parts_tab.dart';
import 'tabs/category_car_parth_tab.dart';

class CarPartsMenu extends StatefulWidget {
  const CarPartsMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CarPartsMenuState createState() => _CarPartsMenuState();
}

class _CarPartsMenuState extends State<CarPartsMenu> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          leading: Container(),
          bottom: TabBar(
            textScaler: TextScaler.linear(Constants.tabTextScale),
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.cars.toUpperCase()),
              Tab(text: AppLocalizations.of(context)!.selected.toUpperCase()),
              Tab(text: AppLocalizations.of(context)!.category.toUpperCase()),
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
