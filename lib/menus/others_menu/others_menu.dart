import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/constants.dart' as constants;
import 'tabs/all_others_tab.dart';
import 'tabs/category_others_tab.dart';
import 'tabs/selection_others_tab.dart';

class OthersMenu extends StatefulWidget {
  const OthersMenu({super.key});

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
          bottom: TabBar(
            textScaler: TextScaler.linear(constants.tabTextScale),

            indicatorColor: Colors.white,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.all.toUpperCase()),
              Tab(text: AppLocalizations.of(context)!.selected.toUpperCase()),
              Tab(text: AppLocalizations.of(context)!.category.toUpperCase()),
            ],
          ),
        ),
        body: const TabBarView(
          children: [AllOthersTab(), SelectionOthersTab(), CategoryOthersTab()],
        ),
      ),
    );
  }
}
