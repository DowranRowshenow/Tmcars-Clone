import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'utils/traffic.dart';
import 'utils/server.dart';
import 'l10n/app_localizations.dart';
import 'utils/locale.dart';
import 'utils/constants.dart' as constants;
import 'utils/storage.dart';
import 'utils/themes.dart';
import 'models/article_category_model.dart';
import 'screens/menu/menu_screen.dart';
import 'components/scroll_behavior.dart';

void main() async {
  // Ensure Flutter is ready.
  WidgetsFlutterBinding.ensureInitialized();

  // Load initial values that providers will need.
  // This keeps the main function clean and focused.
  final initialThemeMode = await Storage().getThemeMode();
  final initialLocale = await Storage().getLocale();
  final initialTrafficMode = await Storage().getTrafficMode();
  // Set preferred orientation once for the entire app lifecycle.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        // Provider now creates and manages its own state.
        ChangeNotifierProvider(
          create: (_) => ThemeManager()..setThemeMode(initialThemeMode),
        ),
        ChangeNotifierProvider(
          create: (_) => LocaleManager()..setLocale(initialLocale.languageCode),
        ),
        ChangeNotifierProvider(
          create: (_) => TrafficManager()..setTrafficMode(initialTrafficMode),
        ),
        // Use FutureProvider to handle async data loading for the UI.
        FutureProvider<List<ArticleCategory>>(
          create: (_) =>
              Server.getArticleCategories(), // Assuming this fetches from server/cache
          initialData: const [], // Provide an empty list initially
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
    return Consumer2<ThemeManager, LocaleManager>(
      builder: (context, themeManager, localeManager, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: constants.appName,
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
              behavior: GlowlessScrollBehavior(),
              child: child!,
            );
          },
          home: const MenuScreen(),
        );
      },
    );
  }
}
