import 'package:flutter/material.dart';

import 'tabs/all_others_tab.dart';
import 'tabs/category_others.tab.dart';
import 'tabs/selection_others_tab.dart';

class OthersMenu extends StatefulWidget {
  const OthersMenu({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OthersMenuState createState() => _OthersMenuState();
}

class _OthersMenuState extends State<OthersMenu> {
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
              Tab(
                text: "HEMMESI",
              ),
              Tab(
                text: "SAÝLANAN",
              ),
              Tab(
                text: "BÖLÜM",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllOthersTab(),
            SelectionOthersTab(),
            CategoryOthersTab(),
          ],
        ),
      ),
    );
  }
}
