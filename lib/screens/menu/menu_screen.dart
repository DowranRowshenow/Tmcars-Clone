import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_drawer.dart';
import '../../components/exit_dialog.dart';
import '../../providers/navigation.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationManager navigationManager = context
        .read<NavigationManager>();

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
            navigationManager.setMenu(MenuState.home);
            return;
          }
        }
      },
      child: Scaffold(
        key: navigationManager.scaffoldKey,
        drawer: CustomDrawer(
          onTap: (MenuState state) {
            navigationManager.scaffoldKey.currentState?.closeDrawer();
            navigationManager.setMenu(state);
          },
        ),
        body: context.watch<NavigationManager>().getCurrentMenu(),
      ),
    );
  }
}
