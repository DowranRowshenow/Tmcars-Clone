import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../menus/add_menu/add_menu.dart';
import '../menus/articles_menu/articles_menu.dart';
import '../menus/car_parts_menu/car_parts_menu.dart';
import '../menus/cars_menu/cars_menu.dart';
import '../menus/comments_menu/comments_menu.dart';
import '../menus/home_menu/home_menu.dart';
import '../menus/others_menu/others_menu.dart';
import '../menus/profiles_menu/profiles_menu.dart';
import '../models/article_detail_model.dart';
import '../models/article_model.dart';
import '../providers/locale.dart';
import '../screens/article/article_detail_screen.dart';
import '../screens/contact/contact_screen.dart';
import '../screens/image_view/image_view_screen.dart';
import '../screens/menu/menu_screen.dart';
import '../screens/notifications/notifications_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/search_articles/search_articles_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/video_view/video_view_screen.dart';
import '../screens/webview/webview_screen.dart';

class _ArticleDetailArgs {
  final Article article;
  final String languageCode;

  const _ArticleDetailArgs({required this.article, required this.languageCode});
}

class _WebViewArgs {
  final String url;
  final String title;

  const _WebViewArgs({required this.url, required this.title});
}

class _ImageViewArgs {
  final List<String> imageUrls;

  const _ImageViewArgs({required this.imageUrls});
}

class _VideoViewArgs {
  final MainVideo video;

  const _VideoViewArgs({required this.video});
}

class _SearchArticleArgs {
  final List<ArticleTag> articleTags;

  const _SearchArticleArgs({required this.articleTags});
}

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
  imageView,
  videoView,
}

class NavigationManager extends ChangeNotifier {
  ScreenState _currentScreen = ScreenState.menu;
  MenuState _currentMenu = MenuState.home;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ScreenState get currentScreen => _currentScreen;
  MenuState get currentMenu => _currentMenu;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  late final Map<MenuState, Widget> _menuWidgets;

  NavigationManager() {
    _menuWidgets = const <MenuState, Widget>{
      MenuState.home: HomeMenu(),
      MenuState.add: AddMenu(),
      MenuState.others: OthersMenu(),
      MenuState.comments: CommentsMenu(),
      MenuState.articles: ArticlesMenu(),
      MenuState.parts: CarPartsMenu(),
      MenuState.cars: CarsMenu(),
      MenuState.profiles: ProfilesMenu(),
    };
  }

  Widget getCurrentMenu() {
    return _menuWidgets[_currentMenu] ??
        const HomeMenu(); // Fallback to HomeMenu
  }

  void setMenu(MenuState state) {
    if (_currentMenu == state) return; // Prevent unnecessary rebuilds
    _currentMenu = state;
    notifyListeners();
  }

  void _navigateToScreen(
    BuildContext context,
    ScreenState state, {
    Object? arguments, // Use Object? for general arguments
  }) {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      _scaffoldKey.currentState?.closeDrawer();
    }

    if (_currentScreen != state) {
      _currentScreen = state;
      // notifyListeners();
    }

    Widget screenToPush; // Changed to non-nullable

    switch (state) {
      case ScreenState.articleDetail:
        final _ArticleDetailArgs? args = arguments as _ArticleDetailArgs?;
        if (args == null) {
          debugPrint('Error: ArticleDetailScreen requires _ArticleDetailArgs.');
          return; // Exit if arguments are missing
        }
        screenToPush = ArticleDetailScreen(
          article: args.article,
          languageCode: args.languageCode,
        );
        break;
      case ScreenState.notifications:
        screenToPush = const NotificationsScreen();
        break;
      case ScreenState.menu:
        screenToPush = const MenuScreen();
        break;
      case ScreenState.settings:
        screenToPush = const SettingsScreen();
        break;
      case ScreenState.contact:
        screenToPush = const ContactScreen();
        break;
      case ScreenState.register:
        screenToPush = const RegisterScreen();
        break;
      case ScreenState.webview:
        final _WebViewArgs? args = arguments as _WebViewArgs?;
        if (args == null) {
          debugPrint('Error: WebViewScreen requires _WebViewArgs.');
          return; // Exit if arguments are missing
        }
        screenToPush = WebViewScreen(url: args.url, title: args.title);
        break;
      case ScreenState.imageView:
        final _ImageViewArgs? args = arguments as _ImageViewArgs?;
        if (args == null) {
          debugPrint('Error: ImageViewScreen requires _ImageViewArgs.');
          return; // Exit if arguments are missing
        }
        screenToPush = ImageViewScreen(imageUrls: args.imageUrls);
        break;
      case ScreenState.videoView:
        final _VideoViewArgs? args = arguments as _VideoViewArgs?;
        if (args == null) {
          debugPrint('Error: ImageViewScreen requires _VideoViewArgs.');
          return; // Exit if arguments are missing
        }
        screenToPush = VideoViewScreen(video: args.video);
        break;
      case ScreenState.searchArticles:
        final _SearchArticleArgs? args = arguments as _SearchArticleArgs?;
        screenToPush = args == null
            ? const SearchArticlesScreen()
            : SearchArticlesScreen(articleTags: args.articleTags);
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext ctx) => screenToPush,
      ), // No '!' needed
    );
  }

  void setScreen(
    BuildContext context,
    ScreenState state, {
    String? url,
    String? title,
    MainVideo? video,
    Article? article,
    List<String>? imageUrls,
    List<ArticleTag>? articleTags,
  }) {
    Object? args;
    if (state == ScreenState.articleDetail) {
      if (article == null) {
        debugPrint(
          'Error: Article argument is required for ArticleDetailScreen.',
        );
        return;
      }
      args = _ArticleDetailArgs(
        article: article,
        languageCode: context.read<LocaleManager>().locale.languageCode,
      );
    } else if (state == ScreenState.webview) {
      if (url == null) {
        debugPrint('Error: URL is required for WebViewScreen.');
        return;
      }
      args = _WebViewArgs(
        url: url,
        title: title ?? "", // Fallback title
      );
    } else if (state == ScreenState.imageView) {
      if (imageUrls == null) {
        debugPrint('Error: imageUrls is required for ImageViewScreen.');
        return;
      }
      args = _ImageViewArgs(imageUrls: imageUrls);
    } else if (state == ScreenState.videoView) {
      if (video == null) {
        debugPrint('Error: imageUrls is required for ImageViewScreen.');
        return;
      }
      args = _VideoViewArgs(video: video);
    } else if (state == ScreenState.searchArticles) {
      if (articleTags != null) {
        args = _SearchArticleArgs(articleTags: articleTags);
      }
    }
    _navigateToScreen(context, state, arguments: args);
  }
}
