// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/app_settings_model.dart';
import '../models/article_category_model.dart';
import '../models/article_detail_model.dart';
import '../models/article_model.dart';
import '../models/article_query_model.dart';
import '../models/car_detail_model.dart';
import '../models/car_list_model.dart';
import '../models/car_model.dart';
import '../models/car_product_filter_model.dart';
import '../models/car_query_model.dart';
import 'storage.dart';

class Server {
  // Consider making this class abstract or using a service locator if it grows
  static const String host = "tapgo.biz:8443";
  static const String host2 = "tm1.tapgo.biz:8443";

  // HTTP client with connection pooling and timeout configuration
  static final http.Client _client = http.Client();

  // Cache for API responses
  static final Map<String, dynamic> _cache = <String, dynamic>{};
  static const Duration _cacheExpiryShort = Duration(minutes: 5);
  static const Duration _cacheExpiry = Duration(minutes: 30);
  static const Duration _cacheExpiryLong = Duration(hours: 1);

  // ENDPOINTS
  static const String currentUrl = '';
  static const String ABOUT_US_URL = 'https://tmcars.info/tm/aboutUs';
  static const String PRIVACY_POLICY_URL = 'https://tmcars.info/tm/terms';
  static const String PRIVACY_POLICY_RU_URL = 'https://tmcars.info/terms';
  static const String CONFIDENTIALS_URL = 'https://tmcars.info/tm/terms';
  static const String CONFIDENTIALS_RU_URL = 'https://tmcars.info/terms';
  static const String COMMENT_POST_POLICY_URL =
      'https://tmcars.info/tm/commentPostingPolicy';
  static const String COMMENT_POST_POLICY_RU_URL =
      'https://tmcars.info/commentPostingPolicy';
  static const String CONTACT_URL =
      'https://dowranrowshenow.github.io/Portfolio/';
  static const String SHARE_LINK =
      'https://play.google.com/store/apps/details?id=com.tm.car';

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  static Future<dynamic> _getCache(String cacheKey, Duration duration) async {
    if (_cache.containsKey(cacheKey)) {
      final dynamic cached = _cache[cacheKey];
      if (cached['timestamp'] != null && cached['data'] != null) {
        if (DateTime.now().difference(cached['timestamp'] as DateTime) <
            duration) {
          return cached;
        }
      }
    }
  }

  static Future<String> _fetchUrl(
    String url, {
    Map<String, String> query = const <String, String>{},
  }) async {
    final http.Response response = await _client
        .get(Uri.https(host, url, query))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      debugPrint("Failed to fetch: $url");
    }
    return "";
  }

  static Future<List<DashFeaturedItem>> getSettings() async {
    const String cacheKey = 'appSettings';
    final dynamic cached = await _getCache(cacheKey, _cacheExpiryLong);

    if (cached != null) {
      return cached['data'].dashFeatured as List<DashFeaturedItem>;
    }

    try {
      final String jsonString = await _fetchUrl(
        "/tmcars/setting/getAppSettingsV1",
      );

      final AppSettings appSettings = AppSettings.fromJson(
        json.decode(jsonString) as Map<String, dynamic>,
      );
      _cache[cacheKey] = <String, Object>{
        'data': appSettings,
        'timestamp': DateTime.now(),
      };
      Storage.instance.cacheAppSettings(jsonString);
      return appSettings.dashFeatured;
    } on TimeoutException catch (e) {
      debugPrint('Error fetching Settings (timeout): $e');
    } catch (e) {
      debugPrint('Error fetching Settings: $e');
    }
    // TODO: make it return null
    return <DashFeaturedItem>[];
  }

  static Future<CarDetail?> getCar(int id) async {
    final String cacheKey = 'car_$id';
    final dynamic cached = await _getCache(cacheKey, _cacheExpiryLong);

    if (cached != null) {
      return cached['data'] as CarDetail;
    }

    try {
      final String jsonString = await _fetchUrl(
        "/tmcars/v1/vehicle/getCar",
        query: <String, String>{'id': id.toString()},
      );

      final CarDetail carDetail = CarDetail.fromJson(
        json.decode(jsonString) as Map<String, dynamic>,
      );
      _cache[cacheKey] = <String, Object>{
        'data': carDetail,
        'timestamp': DateTime.now(),
      };
      return carDetail;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<List<Car>?> getCars(CarQuery? query) async {
    try {
      final String jsonString = await _fetchUrl(
        "/tmcars/carProduct/getCars",
        query: query?.map() ?? <String, String>{},
      );

      final dynamic data = json.decode(jsonString);
      final CarList carList = CarList.fromJson(
        data as Map<String, dynamic>,
        // NOTE: It is for detecting the api response version
        isV2: data["cars"][0]["cityName"] == null ? true : false,
      );

      return carList.cars;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<List<CarProductFilter>> getCarProductFilter(
    CarProductFilter? query,
  ) async {
    final String cacheKey = 'carProducts_${query?.onlyBrand ?? ""}';
    final dynamic cached = await _getCache(cacheKey, _cacheExpiryLong);

    if (cached != null && cached['hashcode'] != query.hashCode) {
      return cached['data'] as List<CarProductFilter>;
    }

    try {
      final String jsonString = await _fetchUrl(
        "/tmcars/carProductFilter/getFilters",
        query: query?.map() ?? <String, String>{},
      );

      final List<CarProductFilter> carProductFilters =
          (json.decode(jsonString) as List<dynamic>)
              .map(
                (dynamic e) =>
                    CarProductFilter.fromJson(e as Map<String, dynamic>),
              )
              .toList();
      _cache[cacheKey] = <String, Object>{
        'data': carProductFilters,
        'timestamp': DateTime.now(),
        'hashcode': query.hashCode,
      };
      return carProductFilters;
    } catch (e) {
      debugPrint("Fetch error getCarProductsFilter $e");
    }
    return <CarProductFilter>[];
  }

  static Future<List<ArticleCategory>?> getArticleCategories() async {
    const String cacheKey = 'article_categories';
    final dynamic cached = await _getCache(cacheKey, _cacheExpiryLong);

    if (cached != null) {
      return cached['data'] as List<ArticleCategory>;
    }

    try {
      final String jsonString = await _fetchUrl(
        "/tmcars/articleCategory/categories",
      );

      final List<ArticleCategory> categories =
          (json.decode(jsonString) as List<dynamic>)
              .map(
                (dynamic e) =>
                    ArticleCategory.fromJson(e as Map<String, dynamic>),
              )
              .toList();
      _cache[cacheKey] = <String, Object>{
        'data': categories,
        'timestamp': DateTime.now(),
      };
      Storage.instance.cacheArticleCategories(jsonString);
      return categories;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<List<Article>?> getArticles(ArticleQuery query) async {
    try {
      final String jsonString = await _fetchUrl(
        "/tmcars/article/articles",
        query: query.map(),
      );

      final List<dynamic> data = json.decode(jsonString) as List<dynamic>;
      return data
          .map((dynamic e) => Article.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<List<Article>?> getNearestArticles(int id) async {
    final String cacheKey = 'nearest_articles_$id';
    final dynamic cached = await _getCache(cacheKey, _cacheExpiry);

    if (cached != null) {
      return cached['data'] as List<Article>;
    }

    try {
      final String jsonString = await _fetchUrl(
        "/tmcars/article/nearestNews",
        query: <String, String>{'sourceId': id.toString()},
      );

      final List<Article> articles = (json.decode(jsonString) as List<dynamic>)
          .map((dynamic e) => Article.fromJson(e as Map<String, dynamic>))
          .toList();
      _cache[cacheKey] = <String, Object>{
        'data': articles,
        'timestamp': DateTime.now(),
      };
      return articles;
    } catch (e) {
      debugPrint('Failed to load nearest articles');
    }
    return null;
  }

  static Future<ArticleDetail?> getArticle(int id) async {
    final String cacheKey = 'article_$id';
    final dynamic cached = await _getCache(cacheKey, _cacheExpiryShort);

    if (cached != null) {
      return cached['data'] as ArticleDetail;
    }

    try {
      final String jsonString = await _fetchUrl(
        "/tmcars/article/getArticle",
        query: <String, String>{'id': id.toString()},
      );

      final ArticleDetail data = ArticleDetail.fromJson(
        json.decode(jsonString) as Map<String, dynamic>,
      );
      _cache[cacheKey] = <String, Object>{
        'data': data,
        'timestamp': DateTime.now(),
      };
      return data;
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
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
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
