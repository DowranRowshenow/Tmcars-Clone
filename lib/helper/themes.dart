import 'package:flutter/material.dart';

import 'constants.dart';

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

  // Light theme custom colors
  static final AppColors light = AppColors(
    themedSurface: Colors.white,
    menuBackgroundColor: Colors.grey.shade400,
    iconThemeColor: Colors.black.withOpacity(0.5),
    textThemeColor: Colors.black.withOpacity(0.8),
    textHintThemeColor: Colors.black.withOpacity(0.5),
    text2ThemeColor: colorPrimary, // Assuming colorPrimary is for light theme
    productSubtitleThemeColor: Colors.black,
    tileThemeColor: Colors.black.withOpacity(0.1),
    scaffoldBackgroundThemeColor:
        Colors.white, // Adjusted for typical light background
  );

  // Dark theme custom colors
  static final AppColors dark = AppColors(
    themedSurface: blueGrey950,
    menuBackgroundColor: Colors.grey.shade800,
    iconThemeColor: Colors.white.withOpacity(0.5),
    textThemeColor: Colors.white.withOpacity(0.8),
    textHintThemeColor: Colors.white.withOpacity(0.5),
    text2ThemeColor:
        Colors.white.withOpacity(0.8), // Assuming this for dark theme
    productSubtitleThemeColor: Colors.white,
    tileThemeColor: Colors.white.withOpacity(0.1),
    scaffoldBackgroundThemeColor: blueGrey950, // A common dark background
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
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      themedSurface: Color.lerp(themedSurface, other.themedSurface, t),
      menuBackgroundColor:
          Color.lerp(menuBackgroundColor, other.menuBackgroundColor, t),
      iconThemeColor: Color.lerp(iconThemeColor, other.iconThemeColor, t),
      textThemeColor: Color.lerp(textThemeColor, other.textThemeColor, t),
      textHintThemeColor:
          Color.lerp(textHintThemeColor, other.textHintThemeColor, t),
      text2ThemeColor: Color.lerp(text2ThemeColor, other.text2ThemeColor, t),
      productSubtitleThemeColor: Color.lerp(
          productSubtitleThemeColor, other.productSubtitleThemeColor, t),
      tileThemeColor: Color.lerp(tileThemeColor, other.tileThemeColor, t),
      scaffoldBackgroundThemeColor: Color.lerp(
          scaffoldBackgroundThemeColor, other.scaffoldBackgroundThemeColor, t),
    );
  }
}

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  bool isDark() {
    return _themeMode == ThemeMode.dark;
  }
}

// Define ThemeData for light and dark modes
final ThemeData lightThemeData = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColors.light.scaffoldBackgroundThemeColor,
  hintColor: AppColors.light.textHintThemeColor,
  iconTheme: IconThemeData(color: AppColors.light.iconThemeColor),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: AppColors.light.textThemeColor,
        displayColor: AppColors.light.textThemeColor,
      ),
  colorScheme: ThemeData.light().colorScheme.copyWith(
        surface: AppColors.light.themedSurface, // For cards, dialogs etc.
        onSurface: AppColors.light.textThemeColor,
        primary:
            colorPrimary, // Assuming colorPrimary is your light theme's primary color
        secondary: colorPrimary, // Adjust as needed
      ),
  appBarTheme: const AppBarTheme(
    elevation: 1.0,
  ),
  extensions: <ThemeExtension<dynamic>>[
    AppColors.light,
  ],
);

final ThemeData darkThemeData = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: AppColors.dark.scaffoldBackgroundThemeColor,
  hintColor: AppColors.dark.textHintThemeColor,
  iconTheme: IconThemeData(color: AppColors.dark.iconThemeColor),
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: AppColors.dark.textThemeColor,
        displayColor: AppColors.dark.textThemeColor,
      ),
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        surface: AppColors.dark.themedSurface,
        onSurface: AppColors.dark.textThemeColor,
        // Define primary/secondary for dark theme if different
      ),
  appBarTheme: const AppBarTheme(
    elevation: 1.0,
  ),
  extensions: <ThemeExtension<dynamic>>[
    AppColors.dark,
  ],
);
