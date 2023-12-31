import 'package:flutter/material.dart';

import 'constants.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  bool isDark() {
    bool isDark = true;
    _themeMode == ThemeMode.dark ? isDark = true : isDark = false;
    return isDark;
  }

  Color drawerColor() {
    Color color = Colors.transparent;
    _themeMode == ThemeMode.dark ? color = blueGrey950 : color = Colors.white;
    return color;
  }

  Color iconColor() {
    Color color = Colors.transparent;
    _themeMode == ThemeMode.dark
        ? color = Colors.white.withOpacity(0.5)
        : color = Colors.black.withOpacity(0.5);
    return color;
  }

  Color textColor() {
    Color color = Colors.transparent;
    _themeMode == ThemeMode.dark
        ? color = Colors.white.withOpacity(0.8)
        : color = Colors.black.withOpacity(0.8);
    return color;
  }

  Color textHintColor() {
    Color color = Colors.transparent;
    _themeMode == ThemeMode.dark
        ? color = Colors.white.withOpacity(0.5)
        : color = Colors.black.withOpacity(0.5);
    return color;
  }

  Color text2Color() {
    Color color = Colors.transparent;
    _themeMode == ThemeMode.dark
        ? color = Colors.white.withOpacity(0.8)
        : color = colorPrimary;
    return color;
  }

  Color productSubtitleColor() {
    Color color = Colors.transparent;
    _themeMode == ThemeMode.dark ? color = Colors.white : color = Colors.black;
    return color;
  }

  Color tileColor() {
    Color color = Colors.transparent;
    _themeMode == ThemeMode.dark
        ? color = Colors.white.withOpacity(0.1)
        : color = Colors.black.withOpacity(0.1);
    return color;
  }
}
