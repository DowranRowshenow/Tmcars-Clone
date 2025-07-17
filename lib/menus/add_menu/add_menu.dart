import 'package:flutter/material.dart';
import 'package:tmcarsclone/components/should_register_dialog.dart';

import '../../helper/constants.dart' as constants;
import '../../l10n/app_localizations.dart';
import 'tabs/add_car_parts_tab.dart';
import 'tabs/add_others_tab.dart';
import 'tabs/add_cars_tab.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
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
              Tab(text: AppLocalizations.of(context)!.parts.toUpperCase()),
              Tab(text: AppLocalizations.of(context)!.others.toUpperCase()),
            ],
          ),
        ),
        body: const TabBarView(
          children: [AddCarsTab(), AddCarPartsTab(), AddOthersTab()],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: constants.colorPrimary,
          child: Icon(Icons.add),
          onPressed: () {
            shouldRegisterDialog(context: context);
          },
        ),
      ),
    );
  }
}
