import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Product.dart';

class Server {
  static String host = "192.168.1.104:8000";
  //static String host = "127.0.0.1:8000";

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  static Future<List<Product>> getProducts({
    String name = '',
    String category = '',
    String priceMin = '',
    String priceMax = '',
    String location = '',
    String limit = '',
  }) async {
    final Map<String, String> queryParams = {
      'format': 'json',
      'name': name,
      'category': category,
      'price_min': priceMin,
      'price_max': priceMax,
      'location': location,
      'limit': limit,
    };
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
  }

  static Future<List<Product>> getPopularProducts() {
    return getProducts(limit: '8');
  }
}
