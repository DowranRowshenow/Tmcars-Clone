// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/article_category_model.dart';
import '../models/article_detail_model.dart';
import '../models/popular_product_model.dart';
import '../models/product_model.dart';
import '../models/article_model.dart';
import 'storage.dart';

class Server {
  // Consider making this class abstract or using a service locator if it grows
  static const String host = "tapgo.biz:8443";
  //static String host = "127.0.0.1:8000";

  // HTTP client with connection pooling and timeout configuration
  static final http.Client _client = http.Client();

  // Cache for API responses
  static final Map<String, dynamic> _cache = {};
  static const Duration _cacheExpiry = Duration(minutes: 1);

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

  static Future<List<PopularProduct>> getSettings() async {
    const String cacheKey = 'popular_products';

    if (_cache.containsKey(cacheKey)) {
      final cached = _cache[cacheKey];
      if (cached['timestamp'] != null &&
          DateTime.now().difference(cached['timestamp']) < _cacheExpiry) {
        return cached['data'] as List<PopularProduct>;
      }
    }

    try {
      final http.Response response = await _client
          .get(Uri.https(host, "/tmcars/setting/getAppSettingsV1"))
          .timeout(const Duration(seconds: 10)); // Added timeout

      if (response.statusCode == 200) {
        List<PopularProduct> products = [];
        final data = json.decode(response.body) as Map<String, dynamic>;
        for (var product in data["dashFeatured"]) {
          product = PopularProduct.fromJson(product);
          products.add(product);
        }
        _cache[cacheKey] = {'data': products, 'timestamp': DateTime.now()};
        return products;
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
    return [];
  }

  static Future<List<ArticleCategory>> getArticleCategories() async {
    const String cacheKey = 'article_categories';

    if (_cache.containsKey(cacheKey)) {
      final cached = _cache[cacheKey];
      if (cached['timestamp'] != null &&
          DateTime.now().difference(cached['timestamp']) < _cacheExpiry) {
        return cached['data'] as List<ArticleCategory>;
      }
    }

    try {
      final response = await _client.get(
        Uri.https(host, "/tmcars/articleCategory/categories"),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final categories = data
            .map((e) => ArticleCategory.fromJson(e))
            .toList();
        _cache[cacheKey] = {'data': categories, 'timestamp': DateTime.now()};
        Storage.instance.setArticleCategories(response.body);
        return categories;
      } else {
        debugPrint('Failed to load news categories');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  static Future<List<Article>> getArticles({
    int offset = 0,
    int max = 40,
    int categoryId = 0,
    String categoryCode = "",
    String mask = "",
    String tags = "",
  }) async {
    final Map<String, dynamic> map = {'max': max.toString()};
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
      final response = await http.get(
        Uri.https(host, "/tmcars/article/articles", map),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) => Article.fromJson(e)).toList();
      } else {
        debugPrint('Failed to load articles');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  static Future<List<Article>> getNearestArticles(int id) async {
    final String cacheKey = 'nearest_articles_$id';

    if (_cache.containsKey(cacheKey)) {
      final cached = _cache[cacheKey];
      if (cached['timestamp'] != null &&
          DateTime.now().difference(cached['timestamp']) < _cacheExpiry) {
        return cached['data'] as List<Article>;
      }
    }

    final Map<String, dynamic> map = {'sourceId': id.toString()};

    try {
      final response = await http.get(
        Uri.https(host, "/tmcars/article/nearestNews", map),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Article> res = data.map((e) => Article.fromJson(e)).toList();
        _cache[cacheKey] = {'data': res, 'timestamp': DateTime.now()};
        return res;
      } else {
        debugPrint('Failed to load articles');
      }
    } catch (e) {
      debugPrint('Failed to load articles');
    }
    return [];
  }

  static Future<ArticleDetail?> getArticle(int id) async {
    final String cacheKey = 'article_$id';

    // Check cache first
    if (_cache.containsKey(cacheKey)) {
      final cached = _cache[cacheKey];
      if (cached['timestamp'] != null &&
          DateTime.now().difference(cached['timestamp']) < _cacheExpiry) {
        return cached['data'] as ArticleDetail;
      }
    }

    final Map<String, dynamic> map = {'id': id.toString()};
    try {
      final response = await http.get(
        Uri.https(host, "/tmcars/article/getArticle", map),
      );
      if (response.statusCode == 200) {
        final ArticleDetail data = ArticleDetail.fromJson(
          json.decode(response.body),
        );
        _cache[cacheKey] = {'data': data, 'timestamp': DateTime.now()};
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
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Accept-Charset': 'utf-8',
          'Accept-Encoding': 'gzip, deflate',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Response headers: ${response.headers}');
        debugPrint('Content-Type: ${response.headers['content-type']}');
        final contentType = response.headers['content-type'] ?? '';
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
    return '';
  }

  static Future<List<Product>> getProducts({
    String name = '',
    String category = '',
    String priceMin = '',
    String priceMax = '',
    String location = '',
    String limit = '',
  }) async {
    /*
    final Map<String, String> queryParams = {
      'format': 'json',
      'name': name,
      'category': category,
      'price_min': priceMin,
      'price_max': priceMax,
      'location': location,
      'limit': limit,
    };
    try {
      final http.Response response = await http.get(
        Uri.http(host, '/api/products/', queryParams),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(utf8convert(response.body));
        List<Product> products = [];
        for (var product in data) {
          product = Product.fromJson(product);
          products.add(product);
        }
        return products;
      } else {
        debugPrint('${response.statusCode}: Product Get Failed!');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }*/
    return [];
  }
}
