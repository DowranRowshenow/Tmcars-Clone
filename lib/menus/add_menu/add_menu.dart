import 'package:flutter/material.dart';

import 'tabs/add_car_parts_tab.dart';
import 'tabs/add_others_tab.dart';
import 'tabs/add_cars_tab.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({Key? key}) : super(key: key);

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
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "AWTOULAGLAR"),
              Tab(text: "AWTOŞAÝLAR"),
              Tab(text: "BEÝLEKILER"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AddCarsTab(),
            AddCarPartsTab(),
            AddOthersTab(),
          ],
        ),
      ),
    );
  }
}
