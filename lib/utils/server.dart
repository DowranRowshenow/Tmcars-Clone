// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tmcarsclone/models/car_model.dart';

import '../models/app_settings_model.dart';
import '../models/article_category_model.dart';
import '../models/article_detail_model.dart';
import '../models/article_model.dart';
import '../models/car_list_model.dart';
import '../models/car_query_model.dart';
import 'storage.dart';

class Server {
  // Consider making this class abstract or using a service locator if it grows
  static const String host = "tapgo.biz:8443";
  //static String host = "127.0.0.1:8000";

  // HTTP client with connection pooling and timeout configuration
  static final http.Client _client = http.Client();

  // Cache for API responses
  static final Map<String, dynamic> _cache = <String, dynamic>{};
  static const Duration _cacheExpiry = Duration(minutes: 3);
  static const Duration _cacheExpiryLong = Duration(minutes: 10);

  // ENDPOINTS
  static const String currentUrl = '';
  static const String CONTACT_URL =
      'https://dowranrowshenow.pythonanywhere.com';
  static const String SHARE_LINK =
      'https://play.google.com/store/apps/details?id=com.tm.car';
  static const String ABOUT_US_URL = 'https://tmcars.info/tm/aboutUs';
  static const String PRIVACY_POLICY_URL = 'https://tmcars.info/tm/terms';
  static const String PRIVACY_POLICY_RU_URL = 'https://tmcars.info/terms';
  static const String CONFIDENTIALS_URL = 'https://tmcars.info/tm/terms';
  static const String CONFIDENTIALS_RU_URL = 'https://tmcars.info/terms';
  static const String COMMENT_POST_POLICY_URL =
      'https://tmcars.info/tm/commentPostingPolicy';
  static const String COMMENT_POST_POLICY_RU_URL =
      'https://tmcars.info/commentPostingPolicy';

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  static Future<List<DashFeaturedItem>> getSettings() async {
    const String cacheKey = 'appSettings';

    if (_cache.containsKey(cacheKey)) {
      final dynamic cached = _cache[cacheKey];
      if (cached['timestamp'] != null) {
        try {
          final DateTime cachedTimestamp = DateTime.parse(
            cached['timestamp'] as String,
          );
          if (DateTime.now().difference(cachedTimestamp) < _cacheExpiryLong) {
            return cached['data']['dashFeatured'] as List<DashFeaturedItem>;
          }
        } catch (e) {
          // Treat cache as expired if timestamp is invalid
          debugPrint(
            'Warning: Could not parse cached timestamp for $cacheKey: $e',
          );
        }
      }
    }

    try {
      final http.Response response = await _client
          .get(Uri.https(host, "/tmcars/setting/getAppSettingsV1"))
          .timeout(const Duration(seconds: 10)); // Added timeout

      if (response.statusCode == 200) {
        AppSettings appSettings = AppSettings.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        _cache[cacheKey] = <String, Object>{
          'data': appSettings,
          'timestamp': DateTime.now(),
        };
        return appSettings.dashFeatured;
      } else {
        debugPrint(
          'Failed to load popular products: ${response.statusCode}, Body: ${response.body}',
        );
      }
    } on TimeoutException catch (e) {
      debugPrint('Error fetching popular products (timeout): $e');
    } catch (e) {
      debugPrint('Error fetching popular products: $e');
    }
    // TODO: make it return null
    return <DashFeaturedItem>[];
  }

  static Future<List<Car>?> getCars(CarQuery? query) async {
    try {
      final http.Response response = await http
          .get(
            Uri.https(
              host,
              "/tmcars/carProduct/getCars",
              // Check if query null and pass map
              query == null ? <String, String>{} : query.map(),
            ),
          )
          .timeout(const Duration(seconds: 10)); // Added timeout

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return CarList.fromJson(
          data as Map<String, dynamic>,
          // NOTE: It is for detecting the api response version
          isV2: data["cars"][0]["cityName"] == null ? true : false,
        ).cars;
      } else {
        debugPrint('Failed to load articles');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<List<ArticleCategory>?> getArticleCategories() async {
    const String cacheKey = 'article_categories';

    if (_cache.containsKey(cacheKey)) {
      final dynamic cached = _cache[cacheKey];
      // Fix: Explicitly cast 'timestamp' to String before parsing
      if (cached['timestamp'] != null) {
        try {
          final DateTime cachedTimestamp = DateTime.parse(
            cached['timestamp'] as String,
          );
          if (DateTime.now().difference(cachedTimestamp) < _cacheExpiry) {
            return cached['data'] as List<ArticleCategory>;
          }
        } catch (e) {
          debugPrint(
            'Warning: Could not parse cached timestamp for $cacheKey: $e',
          );
          // Treat cache as expired if timestamp is invalid
        }
      }
    }

    try {
      final http.Response response = await _client
          .get(Uri.https(host, "/tmcars/articleCategory/categories"))
          .timeout(const Duration(seconds: 10)); // Added timeout

      if (response.statusCode == 200) {
        // Fix: Explicitly cast json.decode result to List<dynamic>
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        // Fix: Explicitly cast each item to Map<String, dynamic> before passing to fromJson
        final List<ArticleCategory> categories = data
            .map(
              (dynamic e) =>
                  ArticleCategory.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        _cache[cacheKey] = <String, Object>{
          'data': categories,
          'timestamp': DateTime.now(),
        };
        Storage.instance.cacheArticleCategories(jsonEncode(response.body));
        return categories;
      } else {
        debugPrint('Failed to load news categories');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<List<Article>?> getArticles({
    int offset = 0,
    int max = 40,
    int categoryId = 0,
    String categoryCode = "",
    String mask = "",
    String tags = "",
  }) async {
    final Map<String, dynamic> map = <String, dynamic>{'max': max.toString()};
    if (offset != 0) {
      map['offset'] = offset.toString();
    }
    if (categoryId != 0) {
      map['categoryId'] = categoryId.toString();
    }
    if (categoryCode != "") {
      map['categoryCode'] = categoryCode;
    }
    if (mask != "") {
      map['mask'] = mask;
    }
    if (tags != "") {
      map['tags'] = tags;
    }

    try {
      final http.Response response = await http
          .get(Uri.https(host, "/tmcars/article/articles", map))
          .timeout(const Duration(seconds: 10)); // Added timeout

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        return data
            .map((dynamic e) => Article.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        debugPrint('Failed to load articles');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<List<Article>?> getNearestArticles(int id) async {
    final String cacheKey = 'nearest_articles_$id';

    if (_cache.containsKey(cacheKey)) {
      final dynamic cached = _cache[cacheKey];
      // Fix: Explicitly cast 'timestamp' to String before parsing
      if (cached['timestamp'] != null) {
        try {
          final DateTime cachedTimestamp = DateTime.parse(
            cached['timestamp'] as String,
          );
          if (DateTime.now().difference(cachedTimestamp) < _cacheExpiry) {
            return cached['data'] as List<Article>;
          }
        } catch (e) {
          debugPrint(
            'Warning: Could not parse cached timestamp for $cacheKey: $e',
          );
          // Treat cache as expired if timestamp is invalid
        }
      }
    }

    final Map<String, dynamic> map = <String, dynamic>{
      'sourceId': id.toString(),
    };

    try {
      final http.Response response = await http
          .get(Uri.https(host, "/tmcars/article/nearestNews", map))
          .timeout(const Duration(seconds: 10)); // Added timeout

      if (response.statusCode == 200) {
        // Fix: Explicitly cast json.decode result to List<dynamic>
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        // Fix: Explicitly cast each item to Map<String, dynamic> before passing to fromJson
        final List<Article> res = data
            .map((dynamic e) => Article.fromJson(e as Map<String, dynamic>))
            .toList();
        _cache[cacheKey] = <String, Object>{
          'data': res,
          'timestamp': DateTime.now(),
        };
        return res;
      } else {
        debugPrint('Failed to load articles');
      }
    } catch (e) {
      debugPrint('Failed to load articles');
    }
    return null;
  }

  static Future<ArticleDetail?> getArticle(int id) async {
    final String cacheKey = 'article_$id';

    // Check cache first
    if (_cache.containsKey(cacheKey)) {
      final dynamic cached = _cache[cacheKey];
      // Fix: Explicitly cast 'timestamp' to String before parsing
      if (cached['timestamp'] != null) {
        try {
          final DateTime cachedTimestamp = DateTime.parse(
            cached['timestamp'] as String,
          );
          if (DateTime.now().difference(cachedTimestamp) < _cacheExpiry) {
            return cached['data'] as ArticleDetail;
          }
        } catch (e) {
          debugPrint(
            'Warning: Could not parse cached timestamp for $cacheKey: $e',
          );
          // Treat cache as expired if timestamp is invalid
        }
      }
    }

    final Map<String, dynamic> map = <String, dynamic>{'id': id.toString()};
    try {
      final http.Response response = await http
          .get(Uri.https(host, "/tmcars/article/getArticle", map))
          .timeout(const Duration(seconds: 10)); // Added timeout

      if (response.statusCode == 200) {
        // Fix: Explicitly cast json.decode result to Map<String, dynamic>
        final ArticleDetail data = ArticleDetail.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        _cache[cacheKey] = <String, Object>{
          'data': data,
          'timestamp': DateTime.now(),
        };
        return data;
      } else {
        debugPrint('Failed to load articles');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<String> fetchHtmlContent(String url) async {
    try {
      final http.Response response = await http
          .get(
            Uri.parse(url),
            headers: <String, String>{
              'Accept':
                  'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
              'Accept-Charset': 'utf-8',
              'Accept-Encoding': 'gzip, deflate',
            },
          )
          .timeout(const Duration(seconds: 10)); // Added timeout

      if (response.statusCode == 200) {
        debugPrint('Response headers: ${response.headers}');
        debugPrint('Content-Type: ${response.headers['content-type']}');
        final String contentType = response.headers['content-type'] ?? '';
        String htmlContent = response.body;
        if (!contentType.toLowerCase().contains('charset')) {
          if (htmlContent.contains('<meta charset="')) {
            return htmlContent;
          } else {
            try {
              htmlContent = utf8.decode(
                response.bodyBytes,
                allowMalformed: true,
              );
            } catch (e) {
              debugPrint('UTF-8 decoding failed, using original: $e');
              htmlContent = response.body;
            }
          }
        }
        if (!htmlContent.contains('<meta charset="') &&
            !htmlContent.contains('charset=')) {
          htmlContent = htmlContent.replaceFirst(
            '<head>',
            '<head><meta charset="utf-8">',
          );
          if (!htmlContent.contains('<head>')) {
            htmlContent =
                '<!DOCTYPE html><html><head><meta charset="utf-8"></head><body>$htmlContent</body></html>';
          }
        }
        return htmlContent;
      } else {
        debugPrint('Failed to load HTML content: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching HTML: $e');
    }
    return "";
  }
}
