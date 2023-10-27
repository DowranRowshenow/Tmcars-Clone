import 'package:flutter/material.dart';

import '../enums.dart';
import '../screens/contact/contact_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/settings/settings_screen.dart';

class Navigate {
  static MenuState currentScreen = MenuState.home;

  static void changeScreen(BuildContext context, MenuState state) {
    switch (state) {
      case MenuState.home:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case MenuState.settings:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
        break;
      case MenuState.contact:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactScreen()),
        );
    }
  }
}
