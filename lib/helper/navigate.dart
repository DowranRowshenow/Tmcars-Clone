import 'package:flutter/material.dart';

import '../screens/notifications/notifications_screen.dart';
import '../components/should_register_dialog.dart';
import '../screens/search_articles/search_articles_screen.dart';
import '../l10n/app_localizations.dart';
import '../menus/car_parts_menu/car_parts_menu.dart';
import '../menus/cars_menu/cars_menu.dart';
import '../menus/profiles_menu/profiles_menu.dart';
import '../menus/comments_menu/comments_menu.dart';
import '../menus/articles_menu/articles_menu.dart';
import '../menus/others_menu/others_menu.dart';
import '../menus/add_menu/add_menu.dart';
import '../menus/home_menu/home_menu.dart';
import '../screens/menu/menu_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/contact/contact_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/webview/webview_screen.dart';
import 'constants.dart' as constants;
import 'server.dart';

class Navigate {
  constants.ScreenState currentScreen = constants.ScreenState.menu;
  constants.MenuState currentMenu = constants.MenuState.home;

  String getMenuTitle(BuildContext context) {
    switch (currentMenu) {
      case constants.MenuState.home:
        return AppLocalizations.of(context)!.home;
      case constants.MenuState.others:
        return AppLocalizations.of(context)!.others;
      case constants.MenuState.add:
        return AppLocalizations.of(context)!.add;
      case constants.MenuState.comments:
        return AppLocalizations.of(context)!.comments;
      case constants.MenuState.articles:
        return AppLocalizations.of(context)!.news;
      case constants.MenuState.profiles:
        return AppLocalizations.of(context)!.profiles;
      case constants.MenuState.parts:
        return AppLocalizations.of(context)!.parts;
      case constants.MenuState.cars:
        return AppLocalizations.of(context)!.cars;
    }
  }

  Widget getCurrentMenu() {
    switch (currentMenu) {
      case constants.MenuState.home:
        return const HomeMenu();
      case constants.MenuState.add:
        return const AddMenu();
      case constants.MenuState.others:
        return const OthersMenu();
      case constants.MenuState.comments:
        return const CommentsMenu();
      case constants.MenuState.articles:
        return const NewsMenu();
      case constants.MenuState.parts:
        return const CarPartsMenu();
      case constants.MenuState.cars:
        return const CarsMenu();
      case constants.MenuState.profiles:
        return const ProfilesMenu();
    }
  }

  List<Widget> getMenuTabs(BuildContext context) {
    switch (constants.navigate.currentMenu) {
      case constants.MenuState.comments:
        return [];
      case constants.MenuState.home:
        return [
          IconButton(
            color: Colors.white,
            onPressed: () {
              constants.navigate.changeScreen(
                context,
                constants.ScreenState.notifications,
              );
            },
            splashRadius: constants.splashRadius,
            icon: const Icon(Icons.notifications),
            splashColor: Colors.transparent,
          ),
        ];
      case constants.MenuState.articles:
        return [
          IconButton(
            color: Colors.white,
            onPressed: () {
              constants.navigate.changeScreen(
                context,
                constants.ScreenState.searchArticles,
              );
            },
            splashRadius: constants.splashRadius,
            icon: const Icon(Icons.search),
            splashColor: Colors.transparent,
          ),
        ];
      case constants.MenuState.others:
        return [
          IconButton(
            color: Colors.white,
            onPressed: () {},
            splashRadius: constants.splashRadius,
            icon: const Icon(Icons.sort),
            splashColor: Colors.transparent,
          ),
          IconButton(
            color: Colors.white,
            onPressed: () {
              shouldRegisterDialog(context: context);
            },
            splashRadius: constants.splashRadius,
            icon: const Icon(Icons.star),
            splashColor: Colors.transparent,
          ),
        ];
      case constants.MenuState.parts:
        return [
          IconButton(
            color: Colors.white,
            onPressed: () {},
            splashRadius: constants.splashRadius,
            icon: const Icon(Icons.sort),
            splashColor: Colors.transparent,
          ),
          IconButton(
            color: Colors.white,
            onPressed: () {
              shouldRegisterDialog(context: context);
            },
            splashRadius: constants.splashRadius,
            icon: const Icon(Icons.star),
            splashColor: Colors.transparent,
          ),
        ];
      case constants.MenuState.cars:
        return [
          IconButton(
            color: Colors.white,
            onPressed: () {},
            splashRadius: constants.splashRadius,
            icon: const Icon(Icons.sort),
            splashColor: Colors.transparent,
          ),
          IconButton(
            color: Colors.white,
            onPressed: () {
              shouldRegisterDialog(context: context);
            },
            splashRadius: constants.splashRadius,
            icon: const Icon(Icons.star),
            splashColor: Colors.transparent,
          ),
        ];
      default:
        break;
    }
    return [Container()];
  }

  void changeMenu(constants.MenuState state) {
    currentMenu = state;
  }

  void changeScreen(
    BuildContext context,
    constants.ScreenState state, {
    String url = Server.currentUrl,
    String title = 'NONE',
  }) {
    constants.scaffold.currentState!.closeDrawer();
    switch (state) {
      case constants.ScreenState.notifications:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationsScreen()),
        );
        break;
      case constants.ScreenState.searchArticles:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchArticlesScreen()),
        );
        break;
      case constants.ScreenState.menu:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MenuScreen()),
        );
        break;
      case constants.ScreenState.settings:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
        break;
      case constants.ScreenState.contact:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactScreen()),
        );
        break;
      case constants.ScreenState.register:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
        break;
      case constants.ScreenState.webview:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(
              url: url,
              title: title == 'NONE' ? getMenuTitle(context) : title,
            ),
          ),
        );
        break;
    }
  }
}
