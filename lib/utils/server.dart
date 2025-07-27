// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:async';
import 'dart:io';

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

    // Check cache first
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

        // Cache the result
        _cache[cacheKey] = {'data': products, 'timestamp': DateTime.now()};

        return products;
      } else {
        debugPrint(
          'Failed to load popular products: ${response.statusCode}, Body: ${response.body}',
        );
        throw HttpException(
          'Failed to load popular products: ${response.statusCode}',
        );
      }
    } on TimeoutException catch (e) {
      debugPrint('Error fetching popular products (timeout): $e');
      throw Exception('Request timed out. Please check your connection.');
    } catch (e) {
      debugPrint('Error fetching popular products: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  static Future<List<ArticleCategory>> getArticleCategories() async {
    const String cacheKey = 'article_categories';

    // Check cache first
    if (_cache.containsKey(cacheKey)) {
      final cached = _cache[cacheKey];
      if (cached['timestamp'] != null &&
          DateTime.now().difference(cached['timestamp']) < _cacheExpiry) {
        return cached['data'] as List<ArticleCategory>;
      }
    }

    final response = await _client.get(
      Uri.https(host, "/tmcars/articleCategory/categories"),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final categories = data.map((e) => ArticleCategory.fromJson(e)).toList();

      // Cache the result
      _cache[cacheKey] = {'data': categories, 'timestamp': DateTime.now()};

      Storage.instance.setArticleCategories(response.body);
      return categories;
    } else {
      throw Exception('Failed to load news categories');
    }
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

    final response = await http.get(
      Uri.https(host, "/tmcars/article/articles", map),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  static Future<List<Article>> getNearestArticles(int id) async {
    final String cacheKey = 'nearest_articles_$id';

    // Check cache first
    if (_cache.containsKey(cacheKey)) {
      final cached = _cache[cacheKey];
      if (cached['timestamp'] != null &&
          DateTime.now().difference(cached['timestamp']) < _cacheExpiry) {
        return cached['data'] as List<Article>;
      }
    }

    final Map<String, dynamic> map = {'sourceId': id.toString()};

    final response = await http.get(
      Uri.https(host, "/tmcars/article/nearestNews", map),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Article> res = data.map((e) => Article.fromJson(e)).toList();

      _cache[cacheKey] = {'data': res, 'timestamp': DateTime.now()};
      return res;
    } else {
      throw Exception('Failed to load articles');
    }
  }

  static Future<ArticleDetail> getArticle(int id) async {
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
      throw Exception('Failed to load articles');
    }
  }

  // Function to fetch HTML content from a URL
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
        // Debug: Print response headers
        debugPrint('Response headers: ${response.headers}');
        debugPrint('Content-Type: ${response.headers['content-type']}');

        // Check if response has proper encoding
        final contentType = response.headers['content-type'] ?? '';
        String htmlContent = response.body;

        // If content-type doesn't specify charset, try to detect it
        if (!contentType.toLowerCase().contains('charset')) {
          // Try to detect encoding from HTML meta tag
          if (htmlContent.contains('<meta charset="')) {
            // HTML has charset meta tag, use it
            return htmlContent;
          } else {
            // Try UTF-8 first, then fallback to other encodings
            try {
              // Force UTF-8 decoding
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

        // Ensure HTML has proper charset meta tag
        if (!htmlContent.contains('<meta charset="') &&
            !htmlContent.contains('charset=')) {
          // Inject UTF-8 charset meta tag if not present
          htmlContent = htmlContent.replaceFirst(
            '<head>',
            '<head><meta charset="utf-8">',
          );
          // If no head tag, add it at the beginning
          if (!htmlContent.contains('<head>')) {
            htmlContent =
                '<!DOCTYPE html><html><head><meta charset="utf-8"></head><body>$htmlContent</body></html>';
          }
        }

        return htmlContent;
      } else {
        // Handle server errors
        throw Exception('Failed to load HTML content: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      debugPrint('Error fetching HTML: $e');
      return '';
    }
  }

  static Future<List<Product>> getProducts({
    String name = '',
    String category = '',
    String priceMin = '',
    String priceMax = '',
    String location = '',
    String limit = '',
  }) async {
    return [];
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
        throw Exception('${response.statusCode}: Product Get Failed!');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }*/
  }
}
