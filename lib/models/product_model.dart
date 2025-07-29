import 'package:equatable/equatable.dart'; // Added for Equatable
import '../utils/server.dart'; // Assuming this path is correct

class ProductLocation extends Equatable {
  final String name;

  const ProductLocation({required this.name}); // Made constructor const

  factory ProductLocation.fromJson(Map<String, dynamic> json) {
    return ProductLocation(
      name: json['name'] as String? ?? '',
    ); // Using ?? for default value
  }

  Map<String, dynamic> toJson() {
    // Added toJson
    return {'name': name};
  }

  @override
  List<Object?> get props => [name]; // Implemented Equatable

  ProductLocation copyWith({String? name}) {
    // Added copyWith
    return ProductLocation(name: name ?? this.name);
  }
}

class ProductCategory extends Equatable {
  final String name;

  const ProductCategory({required this.name}); // Made constructor const

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      name: json['name'] as String? ?? '',
    ); // Using ?? for default value
  }

  Map<String, dynamic> toJson() {
    // Added toJson
    return {'name': name};
  }

  @override
  List<Object?> get props => [name]; // Implemented Equatable

  ProductCategory copyWith({String? name}) {
    // Added copyWith
    return ProductCategory(name: name ?? this.name);
  }
}

class ProductImage extends Equatable {
  final String url;

  const ProductImage({required this.url}); // Made constructor const

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      url: 'http://${Server.host}${json['image'] as String? ?? ''}',
    ); // Using ?? for default value
  }

  Map<String, dynamic> toJson() {
    // Added toJson
    return {
      'url': url,
    }; // Note: This toJson creates 'url', not 'image' as in original fromJson.
    // Adjust if the backend expects 'image' in toJson.
  }

  @override
  List<Object?> get props => [url]; // Implemented Equatable

  ProductImage copyWith({String? url}) {
    // Added copyWith
    return ProductImage(url: url ?? this.url);
  }
}

class Product extends Equatable {
  final int id;
  final String name, description, phone;
  final ProductLocation location;
  final ProductCategory category;
  final List<ProductImage> images;
  final double price;
  final int viewCount;
  final String createdAt, updatedAt;

  const Product({
    // Made constructor const
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
    return Product(
      id: json['id'] as int? ?? 0, // Using ?? for default
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: ProductLocation.fromJson(
        json['location'] as Map<String, dynamic>? ?? {},
      ), // Handle null map
      category: ProductCategory.fromJson(
        json['category'] as Map<String, dynamic>? ?? {},
      ), // Handle null map
      price:
          double.tryParse(json['price']?.toString() ?? '0.0') ??
          0.0, // Safely parse price
      viewCount: json['view_count'] as int? ?? 0,
      images:
          (json['images'] as List<dynamic>?) // Concise list parsing
              ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [], // Default to empty list
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    // Added toJson
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'description': description,
      'location': location.toJson(),
      'category': category.toJson(),
      'price': price,
      'view_count': viewCount,
      'images': images.map((e) => e.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
    // Implemented Equatable
    id,
    name,
    description,
    phone,
    location,
    category,
    price,
    viewCount,
    images,
    createdAt,
    updatedAt,
  ];

  Product copyWith({
    // Added copyWith
    int? id,
    String? name,
    String? description,
    String? phone,
    ProductLocation? location,
    ProductCategory? category,
    List<ProductImage>? images,
    double? price,
    int? viewCount,
    String? createdAt,
    String? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      location: location ?? this.location,
      category: category ?? this.category,
      images: images ?? this.images,
      price: price ?? this.price,
      viewCount: viewCount ?? this.viewCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
