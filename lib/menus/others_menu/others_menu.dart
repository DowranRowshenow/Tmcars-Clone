import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/constants.dart';
import 'tabs/all_others_tab.dart';
import 'tabs/category_others_tab.dart';
import 'tabs/selection_others_tab.dart';

class OthersMenu extends StatelessWidget {
  const OthersMenu({super.key});

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
              Tab(text: appLocalizations.all.toUpperCase()),
              Tab(text: appLocalizations.selected.toUpperCase()),
              Tab(text: appLocalizations.category.toUpperCase()),
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
