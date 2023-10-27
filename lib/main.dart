import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmcars/constants.dart';

import 'components/scroll_behavior.dart';
import 'screens/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: blueGrey950.withOpacity(1),
        splashColor: Colors.transparent,
        highlightColor: Colors.black.withOpacity(0.2),
        splashFactory: InkRipple.splashFactory,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.system,
      /* ThemeMode.system to follow system theme, 
         ThemeMode.light for light theme, 
         ThemeMode.dark for dark theme
      */
      builder: (context, child) {
        return ScrollConfiguration(
            behavior: GlowlessScrollBehavior(), child: child!);
      },
      home: const HomeScreen(),
    );
  }
}
