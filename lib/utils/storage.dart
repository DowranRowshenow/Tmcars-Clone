import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/article_category_model.dart';
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

  Future<void> setLocale(String localeCode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('locale', localeCode);
  }

  Future<Locale> getLocale() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return Locale.fromSubtags(
      languageCode: sharedPreferences.getString('locale') ?? "en",
    );
  }

  Future<void> setTrafficMode(int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('traffic', value);
  }

  Future<int> getTrafficMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt('traffic') ?? 0;
  }

  Future<void> setLocation(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('location', value);
  }

  Future<String> getLocation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('location') ?? "";
  }

  Future<void> setArticleCategories(String data) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/articleCategories.json');
    await file.writeAsString(data);
  }

  Future<List<ArticleCategory>> getArticleCategories() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/articleCategories.json');
    if (!await file.exists()) return [];
    final jsonString = await file.readAsString();
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => ArticleCategory.fromJson(json)).toList();
  }
}
