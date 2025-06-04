// ignore_for_file: file_names

import '../helper/server.dart';

class ProductLocation {
  final String name;

  ProductLocation({
    required this.name,
  });

  factory ProductLocation.fromJson(Map<String, dynamic> json) {
    return ProductLocation(
      name: json['name'],
    );
  }
}

class ProductCategory {
  final String name;

  ProductCategory({
    required this.name,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      name: json['name'],
    );
  }
}

class ProductImage {
  final String url;

  ProductImage({
    required this.url,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      url: 'http://${Server.host}${json['image']}',
    );
  }
}

class Product {
  final int id;
  final String name, description, phone;
  final ProductLocation location;
  final ProductCategory category;
  final List<ProductImage> images;
  final double price;
  final int viewCount;
  final String createdAt, updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.phone,
    required this.description,
    required this.location,
    required this.category,
    required this.price,
    required this.viewCount,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<ProductImage> images = [];
    if (json['images'] != null) {
      for (var image in json['images']) {
        images.add(ProductImage.fromJson(image));
      }
    }
    return Product(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      description: json['description'],
      location: ProductLocation.fromJson(json['location']),
      category: ProductCategory.fromJson(json['category']),
      price: double.parse(json['price']),
      viewCount: json['view_count'],
      images: images,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
