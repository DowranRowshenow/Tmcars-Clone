import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'components/scroll/app_scroll_behavior.dart';
import 'l10n/app_localizations.dart';
import 'models/article_category_model.dart';
import 'providers/locale.dart';
import 'providers/location.dart';
import 'providers/navigation.dart';
import 'providers/themes.dart';
import 'providers/traffic.dart';
import 'screens/menu/menu_screen.dart';
import 'utils/constants.dart';
import 'utils/server.dart';
import 'utils/storage.dart';

// MARKED DOWN HIGH USAGE FREQUENCY WIDGETS WITH {HIGH} AND {DYNAMIC}

// TODO: Setup Hive for caching and
// TODO: Write Documentation and Code Patterns
// TODO: Write Tests Widget Unit
// TODO: Throw Server errors to handle refresh
// TODO: Force Impeller & Optimize shader compile with caching
// TODO: Optimize all widgets & Check Dispose all statefull widgets listeners
// TODO: Change Menus Structure to Indexed

/// A helper class to bundle all the initial data needed by the providers.
/// This makes the main function cleaner and the data flow more explicit.
@immutable
class _InitialData {
  const _InitialData({
    required this.themeMode,
    required this.locale,
    required this.trafficMode,
    required this.location,
    required this.articleCategories,
  });

  final ThemeMode themeMode;
  final Locale locale;
  final int trafficMode;
  final Location location;
  final List<ArticleCategory> articleCategories;
}

void main() async {
  // Ensure Flutter is ready.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage singleton
  final Storage storage = await Storage.getInstance();

  // Load initial values from storage in parallel to speed up app launch.
  // Using a record for concurrent futures is type-safe and avoids index-based errors.
  final (
    ThemeMode themeMode,
    Locale locale,
    int trafficMode,
    Location location,
    List<ArticleCategory> articleCategories,
  ) = await (
    storage.getThemeMode(),
    storage.getLocale(),
    storage.getTrafficMode(),
    storage.getLocation(),
    storage.getArticleCategories(),
  ).wait;

  // Grouping them into a single object improves readability and data flow.
  final _InitialData initialData = _InitialData(
    themeMode: themeMode,
    locale: locale,
    trafficMode: trafficMode,
    location: location,
    articleCategories: articleCategories,
  );

  // Set preferred orientation once for the entire app lifecycle.
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<ThemeManager>(
          create: (_) => ThemeManager()..setThemeMode(initialData.themeMode),
        ),
        ChangeNotifierProvider<LocaleManager>(
          create: (_) =>
              LocaleManager()..setLocale(initialData.locale.languageCode),
        ),
        ChangeNotifierProvider<TrafficManager>(
          create: (_) =>
              TrafficManager()..setTrafficMode(initialData.trafficMode),
        ),
        ChangeNotifierProvider<LocationManager>(
          create: (_) => LocationManager()..setLocation(initialData.location),
        ),
        ChangeNotifierProvider<NavigationManager>(
          create: (_) => NavigationManager(),
        ),
        // Use FutureProvider to handle async data loading for the UI.
        FutureProvider<List<ArticleCategory>?>(
          create: (_) => Server.getArticleCategories(),
          initialData: initialData.articleCategories,
          // Gracefully handle errors, e.g., by logging and returning cached data.
          // This prevents the app from crashing on a failed network request.
          catchError: (BuildContext context, Object? error) {
            developer.log('Failed to fetch article categories', error: error);
            // Return the stale data from storage as a fallback.
            return initialData.articleCategories;
          },
        ),
      ],
      child: const TmcarsApp(),
    ),
  );
}

class TmcarsApp extends StatelessWidget {
  const TmcarsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch only the providers that affect this widget's UI.
    // This is more efficient and readable than using a large Consumer.
    final ThemeManager themeManager = context.watch<ThemeManager>();
    final LocaleManager localeManager = context.watch<LocaleManager>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppLocalizations.of(context)?.appName ?? Constants.appName,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: themeManager.themeMode,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: localeManager.locale,
      builder: (BuildContext context, Widget? child) {
        return ScrollConfiguration(
          behavior: const AppScrollBehavior(),
          child: child!,
        );
      },
      home: const MenuScreen(),
    );
  }
}
