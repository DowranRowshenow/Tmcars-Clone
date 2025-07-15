import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart' as constants;

class Storage extends ChangeNotifier {
  Future<void> setThemeMode(ThemeMode themeMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(
      'themeMode',
      themeMode == ThemeMode.system
          ? 0
          : themeMode == ThemeMode.dark
          ? 1
          : 2,
    );
  }

  Future<ThemeMode> getThemeMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int mode = sharedPreferences.getInt('themeMode') ?? 0;
    constants.appThemeMode = mode == 0
        ? ThemeMode.system
        : mode == 1
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
    return constants.appThemeMode;
  }

  Future<void> setLocale(Locale locale) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('locale', locale.languageCode);
  }

  Future<Locale> getLocale() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return Locale.fromSubtags(
      languageCode: sharedPreferences.getString('locale') ?? "en",
    );
  }
}
