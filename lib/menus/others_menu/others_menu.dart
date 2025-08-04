import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/navigation.dart';
import '../../utils/constants.dart';
import 'tabs/all_others_tab.dart';
import 'tabs/category_others_tab.dart';
import 'tabs/selection_others_tab.dart';

class OthersMenu extends StatelessWidget {
  const OthersMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    final NavigationManager navigationManager = context
        .read<NavigationManager>();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Localizations.of<AppLocalizations>(context, AppLocalizations)!.cars,
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            splashRadius: Constants.splashRadius,
            onPressed: () =>
                navigationManager.scaffoldKey.currentState?.openDrawer(),
            splashColor: Colors.transparent,
          ),
          bottom: TabBar(
            textScaler: const TextScaler.linear(Constants.tabTextScale),
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text: appLocalizations.all.toUpperCase()),
              Tab(text: appLocalizations.selected.toUpperCase()),
              Tab(text: appLocalizations.category.toUpperCase()),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            AllOthersTab(),
            SelectionOthersTab(),
            CategoryOthersTab(),
          ],
        ),
      ),
    );
  }
}
