import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmcarsclone/models/article_model.dart';

import '../models/article_category_model.dart';

class Storage {
  static Storage? _instance;
  static SharedPreferences? _prefs;

  Storage._();

  static Future<Storage> getInstance() async {
    if (_instance == null) {
      _instance = Storage._();
      _prefs = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  static Storage get instance {
    if (_instance == null) {
      throw StateError('Storage not initialized. Call getInstance() first.');
    }
    return _instance!;
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await _getPrefs();
    await prefs.setInt(
      'themeMode',
      themeMode == ThemeMode.system
          ? 0
          : themeMode == ThemeMode.dark
          ? 1
          : 2,
    );
  }

  Future<ThemeMode> getThemeMode() async {
    final prefs = await _getPrefs();
    int mode = prefs.getInt('themeMode') ?? 0;
    return mode == 0
        ? ThemeMode.system
        : mode == 1
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  Future<void> setLocale(String localeCode) async {
    final prefs = await _getPrefs();
    await prefs.setString('locale', localeCode);
  }

  Future<Locale> getLocale() async {
    final prefs = await _getPrefs();
    return Locale.fromSubtags(languageCode: prefs.getString('locale') ?? "en");
  }

  Future<void> setTrafficMode(int value) async {
    final prefs = await _getPrefs();
    await prefs.setInt('traffic', value);
  }

  Future<int> getTrafficMode() async {
    final prefs = await _getPrefs();
    return prefs.getInt('traffic') ?? 0;
  }

  Future<void> setLocation(String value) async {
    final prefs = await _getPrefs();
    await prefs.setString('location', value);
  }

  Future<String> getLocation() async {
    final prefs = await _getPrefs();
    return prefs.getString('location') ?? "";
  }

  Future<void> setArticleCategories(String data) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/articleCategories.json');
      await file.writeAsString(data);
    } catch (e) {
      debugPrint('Error saving article categories: $e');
    }
  }

  Future<List<ArticleCategory>> getArticleCategories() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/articleCategories.json');
      if (!await file.exists()) return [];
      final jsonString = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => ArticleCategory.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error loading article categories: $e');
      return [];
    }
  }

  Future<void> setArticlesByCategory(String data, int id) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/articles_$id.json');
      await file.writeAsString(data);
    } catch (e) {
      debugPrint('Error saving articles for category $id: $e');
    }
  }

  Future<List<Article>> getArticlesByCategory(int id) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/articles_$id.json');
      if (!await file.exists()) return [];
      final jsonString = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Article.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error loading articles for category $id: $e');
      return [];
    }
  }

  Future<SharedPreferences> _getPrefs() async {
    if (_prefs != null) return _prefs!;
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }
}
