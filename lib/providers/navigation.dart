import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmcarsclone/providers/locale.dart';

import '../models/article_model.dart';
import '../screens/article/article_detail_screen.dart';
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
import '../utils/constants.dart';

enum MenuState { home, add, others, comments, articles, profiles, parts, cars }

enum ScreenState {
  menu,
  settings,
  contact,
  register,
  webview,
  searchArticles,
  notifications,
  articleDetail,
}

class NavigationManager extends ChangeNotifier {
  ScreenState _currentScreen = ScreenState.menu;
  MenuState _currentMenu = MenuState.home;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ScreenState get currentScreen => _currentScreen;
  MenuState get currentMenu => _currentMenu;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  String getMenuTitle(BuildContext context) {
    switch (_currentMenu) {
      case MenuState.home:
        return AppLocalizations.of(context)!.home;
      case MenuState.others:
        return AppLocalizations.of(context)!.others;
      case MenuState.add:
        return AppLocalizations.of(context)!.add;
      case MenuState.comments:
        return AppLocalizations.of(context)!.comments;
      case MenuState.articles:
        return AppLocalizations.of(context)!.news;
      case MenuState.profiles:
        return AppLocalizations.of(context)!.profiles;
      case MenuState.parts:
        return AppLocalizations.of(context)!.parts;
      case MenuState.cars:
        return AppLocalizations.of(context)!.cars;
    }
  }

  Widget getCurrentMenu() {
    switch (_currentMenu) {
      case MenuState.home:
        return const HomeMenu();
      case MenuState.add:
        return const AddMenu();
      case MenuState.others:
        return const OthersMenu();
      case MenuState.comments:
        return const CommentsMenu();
      case MenuState.articles:
        return const NewsMenu();
      case MenuState.parts:
        return const CarPartsMenu();
      case MenuState.cars:
        return const CarsMenu();
      case MenuState.profiles:
        return const ProfilesMenu();
    }
  }

  List<Widget> getMenuTabs(BuildContext context) {
    switch (_currentMenu) {
      case MenuState.home:
        return Constants.isRegistered
            ? [
                IconButton(
                  color: Colors.white,
                  onPressed: () {
                    setScreen(context, ScreenState.notifications);
                  },
                  splashRadius: Constants.splashRadius,
                  icon: const Icon(Icons.notifications),
                  splashColor: Colors.transparent,
                ),
              ]
            : [];

      case MenuState.articles:
        return [
          IconButton(
            color: Colors.white,
            onPressed: () {
              setScreen(context, ScreenState.searchArticles);
            },
            splashRadius: Constants.splashRadius,
            icon: const Icon(Icons.search),
            splashColor: Colors.transparent,
          ),
        ];
      case MenuState.others:
        return [
          IconButton(
            color: Colors.white,
            onPressed: () {},
            splashRadius: Constants.splashRadius,
            icon: const Icon(Icons.sort),
            splashColor: Colors.transparent,
          ),
          IconButton(
            color: Colors.white,
            onPressed: () {
              shouldRegisterDialog(context: context);
            },
            splashRadius: Constants.splashRadius,
            icon: const Icon(Icons.star),
            splashColor: Colors.transparent,
          ),
        ];
      case MenuState.parts:
        return [
          IconButton(
            color: Colors.white,
            onPressed: () {},
            splashRadius: Constants.splashRadius,
            icon: const Icon(Icons.sort),
            splashColor: Colors.transparent,
          ),
          IconButton(
            color: Colors.white,
            onPressed: () {
              shouldRegisterDialog(context: context);
            },
            splashRadius: Constants.splashRadius,
            icon: const Icon(Icons.star),
            splashColor: Colors.transparent,
          ),
        ];
      case MenuState.cars:
        return [
          IconButton(
            color: Colors.white,
            onPressed: () {},
            splashRadius: Constants.splashRadius,
            icon: const Icon(Icons.sort),
            splashColor: Colors.transparent,
          ),
          IconButton(
            color: Colors.white,
            onPressed: () {
              shouldRegisterDialog(context: context);
            },
            splashRadius: Constants.splashRadius,
            icon: const Icon(Icons.star),
            splashColor: Colors.transparent,
          ),
        ];
      case MenuState.add:
        return [];
      case MenuState.profiles:
        return [];
      case MenuState.comments:
        return [];
    }
  }

  void setMenu(MenuState state) {
    _currentMenu = state;
    notifyListeners();
  }

  void setScreen(
    BuildContext context,
    ScreenState state, {
    String? url,
    String? title,
    Article? article,
  }) {
    _currentScreen = state;
    _scaffoldKey.currentState!.closeDrawer();
    switch (state) {
      case ScreenState.articleDetail:
        if (article != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailScreen(
                article: article,
                languageCode: context
                    .watch<LocaleManager>()
                    .locale
                    .languageCode,
              ),
            ),
          );
        }
        break;
      case ScreenState.notifications:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationsScreen()),
        );
        break;
      case ScreenState.searchArticles:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchArticlesScreen()),
        );
        break;
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
              url: url ?? "",
              title: title ?? getMenuTitle(context),
            ),
          ),
        );
        break;
    }
  }
}
