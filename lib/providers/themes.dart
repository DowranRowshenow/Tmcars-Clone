import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/storage.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.appBarBackgroundColor,
    required this.appBarForegroundColor,
    required this.themedSurface,
    required this.menuBackgroundColor,
    required this.iconThemeColor,
    required this.textThemeColor,
    required this.textHintThemeColor,
    required this.text2ThemeColor,
    required this.productSubtitleThemeColor,
    required this.tileThemeColor,
    required this.scaffoldBackgroundThemeColor,
    required this.focusColor,
    required this.tintColor,
    required this.dividerColor,
    required this.progressIndicatorColor,
  });

  final Color? appBarBackgroundColor;
  final Color? appBarForegroundColor;
  final Color? themedSurface;
  final Color? menuBackgroundColor;
  final Color? iconThemeColor;
  final Color? textThemeColor;
  final Color? textHintThemeColor;
  final Color? text2ThemeColor;
  final Color? productSubtitleThemeColor;
  final Color? tileThemeColor;
  final Color? scaffoldBackgroundThemeColor;
  final Color? focusColor;
  final Color? tintColor;
  final Color? dividerColor;
  final Color? progressIndicatorColor;

  // Light theme custom colors
  static final AppColors light = AppColors(
    appBarBackgroundColor: Constants.colorPrimary,
    appBarForegroundColor: Colors.white,
    themedSurface: Colors.white,
    menuBackgroundColor: Colors.grey.shade200,
    iconThemeColor: Colors.black.withAlpha(128), // 50% opacity
    textThemeColor: Colors.black.withAlpha(204), // 80% opacity
    textHintThemeColor: Colors.black.withAlpha(128), // 50% opacity
    text2ThemeColor:
        Constants.colorPrimary, // Assuming colorPrimary is for light theme
    productSubtitleThemeColor: Colors.black,
    tileThemeColor: Colors.black.withAlpha(26), // 10% opacity
    scaffoldBackgroundThemeColor: Constants.baseTintColor,
    focusColor: Colors.blue,
    tintColor: const Color.fromARGB(255, 233, 223, 231),
    dividerColor: Colors.black.withAlpha(128), // 50% opacity
    progressIndicatorColor: Constants.colorPrimary,
  );

  // Dark theme custom colors
  static final AppColors dark = AppColors(
    appBarBackgroundColor: Constants.blueGrey950,
    appBarForegroundColor: Colors.white,
    themedSurface: Constants.blueGrey950,
    menuBackgroundColor: Color.fromARGB(145, 102, 102, 102),
    iconThemeColor: Colors.white.withAlpha(128), // 50% opacity
    textThemeColor: Colors.white.withAlpha(204), // 80% opacity
    textHintThemeColor: Colors.white.withAlpha(128), // 50% opacity
    text2ThemeColor: Colors.white.withAlpha(204), // 80% opacity
    productSubtitleThemeColor: Colors.white,
    tileThemeColor: Colors.white.withAlpha(26), // 10% opacity
    scaffoldBackgroundThemeColor:
        Constants.blueGrey950, // A common dark background
    focusColor: const Color.fromARGB(255, 1, 89, 161),
    tintColor: const Color.fromARGB(255, 71, 59, 71),
    dividerColor: Colors.white.withAlpha(128), // 50% opacity
    progressIndicatorColor: Colors.white54,
  );

  @override
  AppColors copyWith({
    Color? appBarBackgroundColor,
    Color? appBarForegroundColor,
    Color? themedSurface,
    Color? menuBackgroundColor,
    Color? iconThemeColor,
    Color? textThemeColor,
    Color? textHintThemeColor,
    Color? text2ThemeColor,
    Color? productSubtitleThemeColor,
    Color? tileThemeColor,
    Color? scaffoldBackgroundThemeColor,
    Color? focusColor,
    Color? tintColor,
    Color? dividerColor,
    Color? progressIndicatorColor,
  }) {
    return AppColors(
      appBarBackgroundColor:
          appBarBackgroundColor ?? this.appBarBackgroundColor,
      appBarForegroundColor:
          appBarForegroundColor ?? this.appBarForegroundColor,
      themedSurface: themedSurface ?? this.themedSurface,
      menuBackgroundColor: menuBackgroundColor ?? this.menuBackgroundColor,
      iconThemeColor: iconThemeColor ?? this.iconThemeColor,
      textThemeColor: textThemeColor ?? this.textThemeColor,
      textHintThemeColor: textHintThemeColor ?? this.textHintThemeColor,
      text2ThemeColor: text2ThemeColor ?? this.text2ThemeColor,
      productSubtitleThemeColor:
          productSubtitleThemeColor ?? this.productSubtitleThemeColor,
      tileThemeColor: tileThemeColor ?? this.tileThemeColor,
      scaffoldBackgroundThemeColor:
          scaffoldBackgroundThemeColor ?? this.scaffoldBackgroundThemeColor,
      focusColor: focusColor ?? this.focusColor,
      tintColor: tintColor ?? this.tintColor,
      dividerColor: dividerColor ?? this.dividerColor,
      progressIndicatorColor:
          progressIndicatorColor ?? this.progressIndicatorColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      appBarBackgroundColor: Color.lerp(
        appBarBackgroundColor,
        other.appBarBackgroundColor,
        t,
      ),
      appBarForegroundColor: Color.lerp(
        appBarForegroundColor,
        other.appBarForegroundColor,
        t,
      ),
      themedSurface: Color.lerp(themedSurface, other.themedSurface, t),
      menuBackgroundColor: Color.lerp(
        menuBackgroundColor,
        other.menuBackgroundColor,
        t,
      ),
      iconThemeColor: Color.lerp(iconThemeColor, other.iconThemeColor, t),
      textThemeColor: Color.lerp(textThemeColor, other.textThemeColor, t),
      textHintThemeColor: Color.lerp(
        textHintThemeColor,
        other.textHintThemeColor,
        t,
      ),
      text2ThemeColor: Color.lerp(text2ThemeColor, other.text2ThemeColor, t),
      productSubtitleThemeColor: Color.lerp(
        productSubtitleThemeColor,
        other.productSubtitleThemeColor,
        t,
      ),
      tileThemeColor: Color.lerp(tileThemeColor, other.tileThemeColor, t),
      scaffoldBackgroundThemeColor: Color.lerp(
        scaffoldBackgroundThemeColor,
        other.scaffoldBackgroundThemeColor,
        t,
      ),
      focusColor: Color.lerp(focusColor, other.focusColor, t),
      tintColor: Color.lerp(tintColor, other.tintColor, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      progressIndicatorColor: Color.lerp(
        progressIndicatorColor,
        other.progressIndicatorColor,
        t,
      ),
    );
  }
}

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode themeMode) {
    if (_themeMode == themeMode) return;
    _themeMode = themeMode;
    notifyListeners();
    Storage().setThemeMode(_themeMode);
  }

  void toggleTheme() {
    final newMode = isDark() ? ThemeMode.light : ThemeMode.dark;
    setThemeMode(newMode);
  }

  bool isDark() {
    return _themeMode == ThemeMode.dark;
  }
}

// Define ThemeData for light and dark modes
final ThemeData lightThemeData = ThemeData.light(useMaterial3: false).copyWith(
  primaryColor: AppColors.light.focusColor,
  primaryColorLight: AppColors.light.focusColor,
  tabBarTheme: TabBarThemeData(indicatorColor: AppColors.light.focusColor),
  scaffoldBackgroundColor: AppColors.light.scaffoldBackgroundThemeColor,
  hintColor: AppColors.light.textHintThemeColor,
  iconTheme: IconThemeData(color: AppColors.light.iconThemeColor),
  focusColor: AppColors.light.focusColor,
  extensions: <ThemeExtension<dynamic>>[AppColors.light],
  splashFactory: InkSparkle.splashFactory,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.light.progressIndicatorColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.light.appBarBackgroundColor,
    foregroundColor: AppColors.light.appBarForegroundColor,
    surfaceTintColor: Colors.transparent,
    elevation: Constants.elevation,
    /*
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Constants.baseTintColor.withAlpha(153),
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: false,
    ),
    */
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.light.focusColor,
    selectionColor: AppColors.light.focusColor,
    selectionHandleColor: Colors.transparent,
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: AppColors.light.textThemeColor,
    displayColor: AppColors.light.textThemeColor,
  ),
  colorScheme: ThemeData.light().colorScheme.copyWith(
    surface: AppColors.light.themedSurface,
    onSurface: AppColors.light.textThemeColor,
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.light.focusColor;
      }
      return null; // Defer to the widget's default.
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.light.focusColor;
      }
      return null; // Defer to the widget's default.
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.light.focusColor
          : null,
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.light.focusColor?.withAlpha(127)
          : null,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.light.focusColor,
    shape: const CircleBorder(),
    elevation: Constants.elevation,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,
    focusElevation: Constants.elevation,
    hoverElevation: Constants.elevation,
    highlightElevation: Constants.elevation,
  ),
);

final ThemeData darkThemeData = ThemeData.dark(useMaterial3: false).copyWith(
  primaryColor: AppColors.dark.focusColor,
  primaryColorDark: AppColors.dark.focusColor,
  tabBarTheme: TabBarThemeData(indicatorColor: AppColors.dark.focusColor),
  scaffoldBackgroundColor: AppColors.dark.scaffoldBackgroundThemeColor,
  hintColor: AppColors.dark.textHintThemeColor,
  focusColor: AppColors.dark.focusColor,
  iconTheme: IconThemeData(color: AppColors.dark.iconThemeColor),
  extensions: <ThemeExtension<dynamic>>[AppColors.dark],
  splashFactory: NoSplash.splashFactory,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.dark.progressIndicatorColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.dark.appBarBackgroundColor,
    foregroundColor: AppColors.dark.appBarForegroundColor,
    surfaceTintColor: Colors.transparent,
    elevation: Constants.elevation,
    /*
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced: true,
    ),
    */
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.dark.focusColor,
    selectionColor: AppColors.dark.focusColor,
    selectionHandleColor: Colors.transparent,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: AppColors.dark.textThemeColor,
    displayColor: AppColors.dark.textThemeColor,
  ),
  colorScheme: ThemeData.dark().colorScheme.copyWith(
    surface: AppColors.dark.themedSurface,
    onSurface: AppColors.dark.textThemeColor,
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: WidgetStateProperty.all(Colors.white),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.dark.focusColor;
      }
      return null; // Defer to the widget's default.
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.dark.focusColor;
      }
      return null; // Defer to the widget's default.
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.dark.focusColor
          : null,
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.dark.focusColor?.withAlpha(127)
          : null,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.dark.focusColor,
    shape: const CircleBorder(),
    foregroundColor: AppColors.dark.textThemeColor,
    elevation: Constants.elevation,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,
    focusElevation: Constants.elevation,
    hoverElevation: Constants.elevation,
    highlightElevation: Constants.elevation,
  ),
);
