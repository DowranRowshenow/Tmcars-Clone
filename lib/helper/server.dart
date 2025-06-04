// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/PopularProduct.dart';
import '../models/Product.dart';

class Server {
  // Consider making this class abstract or using a service locator if it grows
  static String host = "tapgo.biz:8443";
  //static String host = "127.0.0.1:8000";

  // ENDPOINTS
  static const String currentUrl = '';

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
    try {
      final http.Response response = await http
          .get(
            Uri.https(host, "/tmcars/setting/getAppSettingsV1"),
          )
          .timeout(const Duration(seconds: 10)); // Added timeout

      if (response.statusCode == 200) {
        List<PopularProduct> products = [];
        final data = json.decode(response.body) as Map<String, dynamic>;

        for (var product in data["dashFeatured"]) {
          product = PopularProduct.fromJson(product);
          products.add(product);
        }
        return products;
      } else {
        if (kDebugMode) {
          print(
              'Failed to load popular products: ${response.statusCode}, Body: ${response.body}');
        }
        throw HttpException(
            'Failed to load popular products: ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Error fetching popular products (timeout): $e');
      }
      throw Exception('Request timed out. Please check your connection.');
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching popular products: $e');
      }
      throw Exception('An unexpected error occurred: $e');
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
