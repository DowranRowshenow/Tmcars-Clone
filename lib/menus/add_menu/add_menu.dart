import 'package:flutter/material.dart';

import '../../components/should_register_dialog.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/constants.dart';
import 'tabs/add_car_parts_tab.dart';
import 'tabs/add_cars_tab.dart';
import 'tabs/add_others_tab.dart';

class AddMenu extends StatelessWidget {
  const AddMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          bottom: TabBar(
            textScaler: const TextScaler.linear(Constants.tabTextScale),
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text: appLocalizations.cars.toUpperCase()),
              Tab(text: appLocalizations.parts.toUpperCase()),
              Tab(text: appLocalizations.others.toUpperCase()),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[AddCarsTab(), AddCarPartsTab(), AddOthersTab()],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.colorPrimary,
          child: const Icon(Icons.add),
          onPressed: () {
            shouldRegisterDialog(context: context);
          },
        ),
      ),
    );
  }
}
