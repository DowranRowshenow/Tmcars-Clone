import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_drawer.dart';
import '../../components/exit_dialog.dart';
import '../../utils/constants.dart';
import '../../providers/navigation.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    // Use `watch` here to ensure the UI (ApspBar title, body, etc.)
    // rebuilds when the navigation state changes.
    final navigationManager = context.watch<NavigationManager>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        if (navigationManager.scaffoldKey.currentState!.isDrawerOpen) {
          navigationManager.scaffoldKey.currentState!.closeDrawer();
          return;
        } else {
          if (navigationManager.currentMenu == MenuState.home) {
            showExitDialog(context: context);
          } else {
            context.read<NavigationManager>().setMenu(MenuState.home);
            return;
          }
        }
      },
      child: Scaffold(
        key: navigationManager.scaffoldKey,
        appBar: AppBar(
          title: Text(navigationManager.getMenuTitle(context)),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            splashRadius: Constants.splashRadius,
            onPressed: () =>
                navigationManager.scaffoldKey.currentState?.openDrawer(),
            splashColor: Colors.transparent,
          ),
          actions: navigationManager.getMenuTabs(context),
        ),
        drawer: CustomDrawer(
          onTap: (state) {
            navigationManager.scaffoldKey.currentState?.closeDrawer();
            context.read<NavigationManager>().setMenu(state);
          },
        ),
        body: navigationManager.getCurrentMenu(),
      ),
    );
  }
}
