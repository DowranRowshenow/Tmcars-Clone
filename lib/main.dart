import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'helper/constants.dart';
import 'helper/themes.dart';
import 'screens/menu/menu_screen.dart';
import 'components/scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (_) => themeManager, // Use your global themeManager instance
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    // No longer need to manually remove listener if using Provider for rebuilds
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Use Consumer or context.watch to rebuild MaterialApp when themeMode changes
    return Consumer<ThemeManager>(
      builder: (context, manager, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tmcars Clone',
          theme: lightThemeData, // Use the ThemeData from themes.dart
          darkTheme: darkThemeData, // Use the ThemeData from themes.dart
          themeMode: manager.themeMode,
          builder: (context, child) {
            return ScrollConfiguration(
                behavior: GlowlessScrollBehavior(), child: child!);
          },
          home: const MenuScreen(),
        );
      },
    );
  }
}
