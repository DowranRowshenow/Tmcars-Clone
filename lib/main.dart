import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'helper/constants.dart' as constants;
import 'helper/size_config.dart';
import 'helper/storage.dart';
import 'helper/themes.dart';
import 'screens/menu/menu_screen.dart';
import 'components/scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage().loadThemeMode();
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
    ChangeNotifierProvider(
      create: (_) => constants.themeManager,
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
    // No longer need to manually remove listener if using Provider for rebuilds
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Use Consumer or context.watch to rebuild MaterialApp when themeMode changes
    return Consumer<ThemeManager>(
      builder: (context, manager, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: constants.appName,
          theme: lightThemeData, // Use the ThemeData from themes.dart
          darkTheme: darkThemeData, // Use the ThemeData from themes.dart
          themeMode: manager.themeMode,
          builder: (context, child) {
            // Initializing Configures and Variables
            constants.appColors = Theme.of(context).extension<AppColors>()!;
            SizeConfig().init(context);
            return ScrollConfiguration(
              behavior: GlowlessScrollBehavior(),
              child: child!,
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
