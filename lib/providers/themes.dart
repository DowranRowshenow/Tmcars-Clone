import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';
import '../utils/storage.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode themeMode) {
    if (_themeMode == themeMode) return;
    _themeMode = themeMode;
    notifyListeners();
    Storage.instance.setThemeMode(_themeMode);
  }

  void toggleTheme() {
    setThemeMode(isDark() ? ThemeMode.light : ThemeMode.dark);
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
  splashFactory: NoSplash.splashFactory,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.light.progressIndicatorColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.light.appBarBackgroundColor,
    foregroundColor: AppColors.light.appBarForegroundColor,
    surfaceTintColor: Colors.transparent,
    elevation: Constants.elevation,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Constants.baseTintColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
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
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      overlayColor: AppColors.light.dividerColor,
      splashFactory: NoSplash.splashFactory,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.light.focusColor;
      }
      return null; // Defer to the widget's default.
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.light.focusColor;
      }
      return null; // Defer to the widget's default.
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (Set<WidgetState> states) => states.contains(WidgetState.selected)
          ? AppColors.light.focusColor
          : null,
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (Set<WidgetState> states) => states.contains(WidgetState.selected)
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
    systemOverlayStyle: const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      overlayColor: AppColors.dark.dividerColor,
      splashFactory: NoSplash.splashFactory,
    ),
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
    fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.dark.focusColor;
      }
      return null; // Defer to the widget's default.
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.dark.focusColor;
      }
      return null; // Defer to the widget's default.
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (Set<WidgetState> states) => states.contains(WidgetState.selected)
          ? AppColors.dark.focusColor
          : null,
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (Set<WidgetState> states) => states.contains(WidgetState.selected)
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
