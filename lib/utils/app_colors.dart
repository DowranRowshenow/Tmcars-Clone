import 'package:flutter/material.dart';

import 'constants.dart';

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
    required this.tagColor,
    required this.categoryColor,
    required this.buttonColor,
    required this.borderColor,
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
  final Color? tagColor;
  final Color? categoryColor;
  final Color? buttonColor;
  final Color? borderColor;

  // Light theme custom colors
  static final AppColors light = AppColors(
    appBarBackgroundColor: Constants.colorPrimary,
    appBarForegroundColor: Colors.white,
    themedSurface: Colors.white,
    menuBackgroundColor: Colors.grey.shade200,
    iconThemeColor: Colors.black.withAlpha(128), // 50% opacity
    textThemeColor: Colors.black.withAlpha(204), // 80% opacity
    textHintThemeColor: Colors.black.withAlpha(128), // 50% opacity
    text2ThemeColor: Constants.colorPrimary,
    productSubtitleThemeColor: Colors.black,
    tileThemeColor: Colors.black.withAlpha(26), // 10% opacity
    scaffoldBackgroundThemeColor: Constants.baseTintColor,
    focusColor: Colors.blue.withAlpha(128),
    tintColor: const Color.fromARGB(255, 233, 223, 231),
    dividerColor: Colors.black.withAlpha(128), // 50% opacity
    progressIndicatorColor: Constants.colorPrimary,
    categoryColor: Colors.blueGrey.shade100, // Light cyan for tags
    tagColor: Colors.blueGrey.shade100, // Another light cyan for tags
    buttonColor: const Color.fromARGB(255, 234, 240, 252),
    borderColor: Colors.grey,
  );

  // Dark theme custom colors
  static final AppColors dark = AppColors(
    appBarBackgroundColor: Constants.blueGrey950,
    appBarForegroundColor: Colors.white,
    themedSurface: Constants.blueGrey950,
    menuBackgroundColor: const Color.fromARGB(145, 102, 102, 102),
    iconThemeColor: Colors.white.withAlpha(128), // 50% opacity
    textThemeColor: Colors.white.withAlpha(204), // 80% opacity
    textHintThemeColor: Colors.white.withAlpha(128), // 50% opacity
    text2ThemeColor: Colors.white.withAlpha(204), // 80% opacity
    productSubtitleThemeColor: Colors.white,
    tileThemeColor: Colors.white.withAlpha(26), // 10% opacity
    scaffoldBackgroundThemeColor: Constants.blueGrey950,
    focusColor: const Color.fromARGB(128, 1, 89, 161),
    tintColor: const Color.fromARGB(255, 71, 59, 71),
    dividerColor: Colors.white.withAlpha(128), // 50% opacity
    progressIndicatorColor: Colors.white54,
    categoryColor: Colors.blueGrey.shade900, // Dark cyan for tags
    tagColor: Constants.colorPrimary, // Another dark cyan for tags
    buttonColor: const Color.fromARGB(255, 52, 88, 97),
    borderColor: Colors.black12,
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
    Color? tagColor,
    Color? categoryColor,
    Color? buttonColor,
    Color? borderColor,
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
      tagColor: tagColor ?? this.tagColor,
      categoryColor: categoryColor ?? this.categoryColor,
      buttonColor: buttonColor ?? this.buttonColor,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  static Color hexToColor(String hexCode) {
    String colorString = hexCode.replaceAll("#", ""); // Remove '#'
    colorString = colorString.replaceAll("0x", ""); // Remove '0x'
    if (colorString.length == 6) {
      colorString = "FF$colorString"; // Add full opacity if missing
    }
    return Color(int.parse(colorString, radix: 16));
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
      tagColor: Color.lerp(tagColor, other.tagColor, t),
      categoryColor: Color.lerp(categoryColor, other.categoryColor, t),
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
    );
  }
}
