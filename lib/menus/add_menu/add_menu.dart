import 'package:flutter/material.dart';

import '../../helper/strings.dart';
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
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: Localization.cars.toUpperCase()),
              Tab(text: Localization.parts.toUpperCase()),
              Tab(text: Localization.others.toUpperCase()),
            ],
          ),
        ),
        body: const TabBarView(
          children: [AddCarsTab(), AddCarPartsTab(), AddOthersTab()],
        ),
      ),
    );
  }
}
