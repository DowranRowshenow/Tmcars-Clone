import 'package:flutter/material.dart';
import 'package:tmcars/menus/profiles_menu/profiles_menu.dart';

import '../menus/comments_menu/comments_menu.dart';
import '../menus/news_menu/news_menu.dart';
import '../menus/others_menu/others_menu.dart';
import '../menus/add_menu/add_menu.dart';
import '../menus/home_menu/home_menu.dart';
import '../screens/menu/menu_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/contact/contact_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/webview/webview_screen.dart';
import 'constants.dart';
import 'server.dart';

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
      case MenuState.comments:
        return "Teswirler";
      case MenuState.news:
        return "Habarlar";
      case MenuState.profiles:
        return "Biznes hasaplar";
      case MenuState.parts:
        return "Awtoşaýlar";
      case MenuState.cars:
        return "Awtoulaglar";
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
      case MenuState.comments:
        return const CommentsMenu();
      case MenuState.news:
        return const NewsMenu();
      case MenuState.parts:
        return const CommentsMenu();
      case MenuState.cars:
        return const CommentsMenu();
      case MenuState.profiles:
        return const ProfilesMenu();
    }
  }

  List<Widget> getMenuTabs() {
    switch (navigate.currentMenu) {
      case MenuState.comments:
        return [];
      case MenuState.news:
        return [
          IconButton(
            onPressed: () {},
            splashRadius: splashRadius,
            icon: const Icon(Icons.search),
          ),
        ];
      case MenuState.others:
        return [
          IconButton(
            onPressed: () {},
            splashRadius: splashRadius,
            icon: const Icon(Icons.sort),
          ),
          IconButton(
            onPressed: () {},
            splashRadius: splashRadius,
            icon: const Icon(Icons.star),
          ),
        ];
      case MenuState.parts:
        return [
          IconButton(
            onPressed: () {},
            splashRadius: splashRadius,
            icon: const Icon(Icons.sort),
          ),
          IconButton(
            onPressed: () {},
            splashRadius: splashRadius,
            icon: const Icon(Icons.star),
          ),
        ];
      case MenuState.cars:
        return [
          IconButton(
            onPressed: () {},
            splashRadius: splashRadius,
            icon: const Icon(Icons.sort),
          ),
          IconButton(
            onPressed: () {},
            splashRadius: splashRadius,
            icon: const Icon(Icons.star),
          ),
        ];
      default:
        break;
    }
    return [Container()];
  }

  void changeMenu(MenuState state) {
    currentMenu = state;
  }

  void changeScreen(BuildContext context, ScreenState state,
      {String url = Server.currentUrl, String title = 'NONE'}) {
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
      case ScreenState.webview:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(
              url: url,
              title: title == 'NONE' ? getMenuTitle() : title,
            ),
          ),
        );
        break;
    }
  }
}
