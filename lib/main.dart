import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'helper/server.dart';
import 'l10n/app_localizations.dart';
import 'helper/locale.dart';
import 'helper/constants.dart' as constants;
import 'helper/size_config.dart';
import 'helper/storage.dart';
import 'helper/themes.dart';
import 'models/article_category_model.dart';
import 'screens/menu/menu_screen.dart';
import 'components/scroll_behavior.dart';

void main() async {
  Future<List<ArticleCategory>> loadCategories() async {
    List<ArticleCategory> cats = await Storage().getArticleCategories();
    if (cats.isEmpty) {
      cats = await Server.getArticleCategories();
    }
    return cats;
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Storage().getThemeMode();
  constants.trafficMode = await Storage().getTrafficMode();
  constants.locale = await Storage().getLocale();
  constants.articleCategory = loadCategories();

  // Enable edge-to-edge display for the app
  /*
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );*/
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => constants.themeManager),
        ChangeNotifierProvider(
          create: (_) => LocaleManager()..setLocale(constants.locale),
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Use Consumer or context.watch to rebuild MaterialApp when themeMode changes
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
            // Initializing Configures and Variables
            constants.appColors = Theme.of(context).extension<AppColors>()!;
            SizeConfig().init(context);
            return ScrollConfiguration(
              behavior: GlowlessScrollBehavior(),
              child: AnimatedTheme(
                data: themeManager.themeMode == ThemeMode.light
                    ? lightThemeData
                    : darkThemeData,
                duration: Duration(milliseconds: 300),
                child: child!,
              ),
            );
          },
          home: LayoutBuilder(
            builder: (context, constraints) {
              return const MenuScreen();
            },
          ),
        );
      },
    );
  }
}
