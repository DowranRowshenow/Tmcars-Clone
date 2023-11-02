import 'package:flutter/material.dart';
import 'package:tmcars/menus/others_menu/others_menu.dart';

import '../menus/add_menu/add_menu.dart';
import '../menus/home_menu/home_menu.dart';
import '../screens/menu/menu_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/contact/contact_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../constants.dart';

class Navigate {
  ScreenState currentScreen = ScreenState.menu;
  MenuState currentMenu = MenuState.home;

  String getMenuTitle() {
    switch (currentMenu) {
      case MenuState.home:
        return "Baş sahypa";
      case MenuState.others:
        return "Beýleki bildirişler";
      case MenuState.add:
        return "Bildiriş goşmak";
    }
  }

  Widget getCurrentMenu() {
    switch (currentMenu) {
      case MenuState.home:
        return const HomeMenu();
      case MenuState.add:
        return const AddMenu();
      case MenuState.others:
        return const OthersMenu();
    }
  }

  void changeMenu(MenuState state) {
    currentMenu = state;
  }

  void changeScreen(BuildContext context, ScreenState state) {
    switch (state) {
      case ScreenState.menu:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MenuScreen()),
        );
        break;
      case ScreenState.settings:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
        break;
      case ScreenState.contact:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactScreen()),
        );
        break;
      case ScreenState.register:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
        break;
    }
  }
}
