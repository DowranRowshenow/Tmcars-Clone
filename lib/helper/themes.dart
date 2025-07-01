import 'package:flutter/material.dart';

import 'constants.dart' as constants;
import 'storage.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
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
    themedSurface: Colors.white,
    menuBackgroundColor: Colors.grey.shade400,
    iconThemeColor: Colors.black.withValues(alpha: 0.5),
    textThemeColor: Colors.black.withValues(alpha: 0.8),
    textHintThemeColor: Colors.black.withValues(alpha: 0.5),
    text2ThemeColor:
        constants.colorPrimary, // Assuming colorPrimary is for light theme
    productSubtitleThemeColor: Colors.black,
    tileThemeColor: Colors.black.withValues(alpha: 0.1),
    scaffoldBackgroundThemeColor: Colors.white,
    focusColor: Colors.blue,
    tintColor: const Color.fromARGB(255, 233, 223, 231),
    dividerColor: Colors.black.withValues(alpha: 0.5),
    progressIndicatorColor: constants.colorPrimary,
  );

  // Dark theme custom colors
  static final AppColors dark = AppColors(
    themedSurface: constants.blueGrey950,
    menuBackgroundColor: Colors.grey.shade800,
    iconThemeColor: Colors.white.withValues(alpha: 0.5),
    textThemeColor: Colors.white.withValues(alpha: 0.8),
    textHintThemeColor: Colors.white.withValues(alpha: 0.5),
    text2ThemeColor: Colors.white.withValues(
      alpha: 0.8,
    ), // Assuming this for dark theme
    productSubtitleThemeColor: Colors.white,
    tileThemeColor: Colors.white.withValues(alpha: 0.1),
    scaffoldBackgroundThemeColor:
        constants.blueGrey950, // A common dark background
    focusColor: const Color.fromARGB(255, 1, 89, 161),
    tintColor: const Color.fromARGB(255, 71, 59, 71),
    dividerColor: Colors.white.withValues(alpha: 0.5),
    progressIndicatorColor: Colors.black54,
  );

  @override
  AppColors copyWith({
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
      tintColor: Color.lerp(tintColor, other.focusColor, t),
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
  ThemeMode? _themeMode = constants.appThemeMode;

  ThemeMode? get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = isDark() ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    Storage().setThemeMode(_themeMode!);
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
  scaffoldBackgroundColor: constants.baseTintColor,
  hintColor: AppColors.light.textHintThemeColor,
  iconTheme: IconThemeData(color: AppColors.light.iconThemeColor),
  focusColor: AppColors.light.focusColor,
  extensions: <ThemeExtension<dynamic>>[AppColors.light],
  splashFactory: InkSparkle.splashFactory,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.light.progressIndicatorColor,
  ),
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.transparent,
    backgroundColor: constants.colorPrimary,
    elevation: constants.elevation,
    /*
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: constants.baseTintColor.withAlpha(153),
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
    elevation: constants.elevation,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,
    focusElevation: constants.elevation,
    hoverElevation: constants.elevation,
    highlightElevation: constants.elevation,
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
  splashFactory: InkSparkle.splashFactory,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.dark.progressIndicatorColor,
  ),
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.transparent,
    backgroundColor: AppColors.dark.themedSurface,
    elevation: constants.elevation,
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
    elevation: constants.elevation,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,
    focusElevation: constants.elevation,
    hoverElevation: constants.elevation,
    highlightElevation: constants.elevation,
  ),
);
