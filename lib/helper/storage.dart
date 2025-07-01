import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart' as constants;

class Storage {
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

  Future<ThemeMode> loadThemeMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int mode = sharedPreferences.getInt('themeMode') ?? 0;
    constants.appThemeMode = mode == 0
        ? ThemeMode.system
        : mode == 1
        ? ThemeMode.dark
        : ThemeMode.light;
    return constants.appThemeMode;
  }
}
