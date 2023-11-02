import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/menu/menu_screen.dart';
import 'constants.dart';
import 'components/scroll_behavior.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tmcars Clone',
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: colorPrimary,
          elevation: 1,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.black.withOpacity(0.2),
        splashFactory: InkRipple.splashFactory,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: blueGrey950.withOpacity(1),
          elevation: 1,
        ),
        primarySwatch: Colors.blue,
        indicatorColor: Colors.black,
        scaffoldBackgroundColor: blueGrey950.withOpacity(1),
        splashColor: Colors.transparent,
        highlightColor: Colors.black.withOpacity(0.2),
        splashFactory: InkRipple.splashFactory,
      ),
      themeMode: themeManager.themeMode,
      builder: (context, child) {
        return ScrollConfiguration(
            behavior: GlowlessScrollBehavior(), child: child!);
      },
      home: const MenuScreen(),
    );
  }
}
