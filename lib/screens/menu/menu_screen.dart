import 'package:flutter/material.dart';

import '../../components/custom_drawer.dart';
import '../../components/exit_dialog.dart';
import '../../utils/constants.dart' as constants;
import '../../utils/themes.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    constants.appColors = Theme.of(context).extension<AppColors>()!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        if (constants.scaffold.currentState!.isDrawerOpen) {
          constants.scaffold.currentState!.closeDrawer();
          return;
        } else {
          if (constants.navigate.currentMenu == constants.MenuState.home) {
            showExitDialog(context: context);
          } else {
            setState(() {
              constants.navigate.changeMenu(constants.MenuState.home);
            });
            return;
          }
        }
      },
      child: Scaffold(
        key: constants.scaffold,
        appBar: AppBar(
          title: Text(constants.navigate.getMenuTitle(context)),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            splashRadius: constants.splashRadius,
            onPressed: () => constants.scaffold.currentState?.openDrawer(),
            splashColor: Colors.transparent,
          ),
          actions: constants.navigate.getMenuTabs(context),
        ),
        drawer: CustomDrawer(
          onTap: (state) {
            setState(() {
              constants.scaffold.currentState!.closeDrawer();
              constants.navigate.currentMenu = state;
            });
          },
        ),
        body: constants.navigate.getCurrentMenu(),
      ),
    );
  }
}
