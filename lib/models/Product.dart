// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tmcars/server.dart';

class ProductBrand {
  final String name;

  ProductBrand({
    required this.name,
  });

  factory ProductBrand.fromJson(Map<String, dynamic> json) {
    return ProductBrand(
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

class ProductSize {
  final int size;

  ProductSize({
    required this.size,
  });

  factory ProductSize.fromJson(Map<String, dynamic> json) {
    return ProductSize(
      size: json['size'],
    );
  }
}

class ProductColor {
  final String name;
  final Color color;

  ProductColor({required this.name, required this.color});

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    String name = json['name'] ?? 'Black';
    Color color = name == "Black"
        ? Colors.black
        : name == "White"
            ? Colors.white
            : name == "Grey"
                ? Colors.grey
                : name == "Red"
                    ? Colors.red
                    : name == "Yellow"
                        ? Colors.yellow
                        : name == "Green"
                            ? Colors.green
                            : Colors.black;
    return ProductColor(name: name, color: color);
  }
}

class Product {
  final int id;
  final String name, description, barcode;
  final ProductBrand brand;
  final ProductCategory category;
  final List<ProductImage> images;
  final List<ProductColor> colors;
  final List<ProductSize> sizes;
  final double price, salePrice;
  final int countSold, quantity;

  final bool isFavourite, isPopular;
  final double rating;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.brand,
    required this.category,
    required this.barcode,
    required this.quantity,
    required this.price,
    required this.salePrice,
    required this.countSold,
    required this.images,
    required this.colors,
    required this.sizes,
    this.isFavourite = true,
    this.isPopular = true,
    this.rating = 4.5,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<ProductImage> images = [];
    if (json['images'] != null) {
      for (var image in json['images']) {
        images.add(ProductImage.fromJson(image));
      }
    }
    List<ProductColor> colors = [];
    if (json['colors'] != null) {
      for (var color in json['colors']) {
        colors.add(ProductColor.fromJson(color));
      }
    }
    List<ProductSize> sizes = [];
    if (json['sizes'] != null) {
      for (var size in json['sizes']) {
        sizes.add(ProductSize.fromJson(size));
      }
    }
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      brand: ProductBrand.fromJson(json['brand']),
      category: ProductCategory.fromJson(json['category']),
      quantity: json['quantity'],
      price: double.parse(json['price']),
      salePrice: double.parse(json['price_on_ale'] ?? "0"),
      barcode: json['barcode'],
      countSold: json['count_sold'],
      images: images,
      colors: colors,
      sizes: sizes,
    );
  }
}
