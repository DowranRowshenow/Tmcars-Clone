import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../helper/constants.dart' as constants;
import 'tabs/all_cars_tab.dart';
import 'tabs/categeory_cars_tab.dart';
import 'tabs/selection_cars_tab.dart';

class CarsMenu extends StatefulWidget {
  const CarsMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CarsMenuState createState() => _CarsMenuState();
}

class _CarsMenuState extends State<CarsMenu> {
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
            textScaler: TextScaler.linear(constants.tabTextScale),
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.cars.toUpperCase()),
              Tab(text: AppLocalizations.of(context)!.selected.toUpperCase()),
              Tab(text: AppLocalizations.of(context)!.category.toUpperCase()),
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
