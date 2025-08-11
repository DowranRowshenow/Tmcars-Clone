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

  Future<SharedPreferences> _getPrefs() async {
    if (_prefs != null) return _prefs!;
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

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
    print(mode);
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

  Future<List<ArticleCategory>> getArticleCategories() async {
    final String jsonString = await getData("articleCategories");
    try {
      if (jsonString.isNotEmpty) {
        final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
        return jsonList
            .map(
              (dynamic json) =>
                  ArticleCategory.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading article categories: $e');
    }
    return <ArticleCategory>[];
  }

  Future<List<Article>> getArticlesByCategory(int id) async {
    final String jsonString = await getData('articles_$id');
    try {
      if (jsonString.isNotEmpty) {
        return (jsonDecode(jsonString) as List<dynamic>)
            .map(
              (dynamic json) => Article.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading articles for category $id: $e');
    }
    return <Article>[];
  }

  Future<void> cacheArticleCategories(String data) async {
    cacheData("article_categories", data);
  }

  Future<void> cacheArticles(int? categoryId, List<Article> articles) async {
    if (categoryId == null) return;
    final String articlesJson = jsonEncode(
      articles.map((Article a) => a.toJson()).toList(),
    );
    cacheData("articles_$categoryId", articlesJson);
  }

  Future<void> cacheAppSettings(String data) async {
    cacheData("appSettings", data);
  }

  Future<void> cacheData(String cacheKey, String data) async {
    try {
      if (kIsWeb) {
        // Use shared_preferences for web
        (await _getPrefs()).setString(cacheKey, data);
      } else {
        // Use path_provider and dart:io for native
        final Directory directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/$cacheKey.json');
        await file.writeAsString(data);
      }
    } catch (e) {
      debugPrint('Error saving $cacheKey: $e');
    }
  }

  Future<String> getData(String cacheKey) async {
    try {
      if (kIsWeb) {
        // Use shared_preferences for web
        return (await _getPrefs()).getString(cacheKey) ?? "";
      } else {
        // Use path_provider and dart:io for native
        final Directory directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/$cacheKey.json');
        return await file.readAsString();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return "";
  }
}
