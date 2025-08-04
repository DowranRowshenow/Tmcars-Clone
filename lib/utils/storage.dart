import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/article_category_model.dart';
import '../models/article_model.dart';
import '../providers/location.dart';

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
    final SharedPreferences prefs = await _getPrefs();
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
    final SharedPreferences prefs = await _getPrefs();
    int mode = prefs.getInt('themeMode') ?? 0;
    return mode == 0
        ? ThemeMode.system
        : mode == 1
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  Future<void> setLocale(String localeCode) async {
    final SharedPreferences prefs = await _getPrefs();
    await prefs.setString('locale', localeCode);
  }

  Future<Locale> getLocale() async {
    final SharedPreferences prefs = await _getPrefs();
    return Locale.fromSubtags(languageCode: prefs.getString('locale') ?? "en");
  }

  Future<void> setTrafficMode(int value) async {
    final SharedPreferences prefs = await _getPrefs();
    await prefs.setInt('traffic', value);
  }

  Future<int> getTrafficMode() async {
    final SharedPreferences prefs = await _getPrefs();
    return prefs.getInt('traffic') ?? 0;
  }

  Future<void> setLocation(Location location) async {
    final SharedPreferences prefs = await _getPrefs();
    await prefs.setString('location', location.toString());
  }

  Future<Location> getLocation() async {
    final SharedPreferences prefs = await _getPrefs();
    return LocationManager.getLocationFromString(
      prefs.getString('location') ?? "none",
    );
  }

  Future<void> cacheArticleCategories(String data) async {
    try {
      if (kIsWeb) {
        // Use shared_preferences for web
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('article_categories', data);
      } else {
        // Use path_provider and dart:io for native
        final Directory directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/articles.json');
        await file.writeAsString(data);
      }
    } catch (e) {
      debugPrint('Error saving article categories: $e');
    }
  }

  Future<List<ArticleCategory>> getArticleCategories() async {
    try {
      String jsonString = "";
      if (kIsWeb) {
        // Use shared_preferences for web
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        jsonString = prefs.getString('article_categories') ?? "";
      } else {
        // Use path_provider and dart:io for native
        final Directory directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/articleCategories.json');
        jsonString = await file.readAsString();
        // if (!await file.exists()) return <ArticleCategory>[];
      }
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map(
            (dynamic json) =>
                ArticleCategory.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      debugPrint('Error loading article categories: $e');
      return <ArticleCategory>[];
    }
  }

  Future<void> cacheData(int id, String data) async {
    try {
      if (kIsWeb) {
        // Use shared_preferences for web
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('articles_$id', data);
      } else {
        // Use path_provider and dart:io for native
        final Directory directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/articles_$id.json');
        await file.writeAsString(data);
      }
    } catch (e) {
      debugPrint('Error saving articles for category $id: $e');
    }
  }

  Future<void> cacheArticles(int? categoryId, List<Article> articles) async {
    if (categoryId == null) return;
    final String articlesJson = jsonEncode(
      articles.map((Article a) => a.toJson()).toList(),
    );
    cacheData(categoryId, articlesJson);
  }

  Future<List<Article>> getArticlesByCategory(int id) async {
    try {
      String jsonString = "";
      if (kIsWeb) {
        // Use shared_preferences for web
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        jsonString = prefs.getString('articles_$id') ?? "";
      } else {
        // Use path_provider and dart:io for native
        final Directory directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/articles_$id.json');
        jsonString = await file.readAsString();
        // if (!await file.exists()) return <Article>[];
      }
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((dynamic json) => Article.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error loading articles for category $id: $e');
      return <Article>[];
    }
  }

  Future<SharedPreferences> _getPrefs() async {
    if (_prefs != null) return _prefs!;
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }
}
