import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

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

// TODO: Write Documentation and Code Patterns
// TODO: Write Tests Widget Unit
// TODO: Throw Server errors to handle refresh
// TODO: Articles_menu list gets empty list on server error leading to clear existing cached list to clear.
// TODO: Don't write functions of {onTap} or {onPressed} in custom Component widgets
// TODO: Force Impeller
// TODO: Optimize shader compile with caching
// TODO: Dispose() all statefull widgets
// TODO: Optimize all widgets
// TODO: Change Menus Structure to Indexed

void main() async {
  // Ensure Flutter is ready.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage singleton
  final Storage storage = await Storage.getInstance();

  // Load initial values that providers will need.
  // This keeps the main function clean and focused.
  final ThemeMode initialThemeMode = await storage.getThemeMode();
  final Locale initialLocale = await storage.getLocale();
  final int initialTrafficMode = await storage.getTrafficMode();
  final Location initialLocation = await storage.getLocation();
  final List<ArticleCategory> initialArticleCategories = await storage
      .getArticleCategories();
  // Set preferred orientation once for the entire app lifecycle.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        // Provider now creates and manages its own state.
        ChangeNotifierProvider<ThemeManager>(
          create: (_) => ThemeManager()..setThemeMode(initialThemeMode),
        ),
        ChangeNotifierProvider<LocaleManager>(
          create: (_) => LocaleManager()..setLocale(initialLocale.languageCode),
        ),
        ChangeNotifierProvider<TrafficManager>(
          create: (_) => TrafficManager()..setTrafficMode(initialTrafficMode),
        ),
        ChangeNotifierProvider<LocationManager>(
          create: (_) => LocationManager()..setLocation(initialLocation),
        ),
        ChangeNotifierProvider<NavigationManager>(
          create: (_) => NavigationManager(),
        ),
        // Use FutureProvider to handle async data loading for the UI.
        FutureProvider<List<ArticleCategory>>(
          create: (_) => Server.getArticleCategories(),
          initialData: initialArticleCategories,
        ),
      ],
      child: const TmcarsClone(),
    ),
  );
}

class TmcarsClone extends StatefulWidget {
  const TmcarsClone({super.key});

  @override
  State<TmcarsClone> createState() => _TmcarsCloneState();
}

class _TmcarsCloneState extends State<TmcarsClone> {
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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: localeManager.locale,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: AppScrollBehavior(),
          child: child!,
        );
      },
      home: const MenuScreen(),
    );
  }
}
