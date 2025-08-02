import 'package:equatable/equatable.dart'; // Added for Equatable

class ArticleCategory extends Equatable {
  final int id;
  final String categoryName;
  final String categoryNameRu;
  final String imgUrl;
  final String code;
  final String colorCode;

  const ArticleCategory({
    // Made constructor const
    required this.id,
    required this.categoryName,
    required this.categoryNameRu,
    required this.imgUrl,
    required this.code,
    required this.colorCode,
  });

  factory ArticleCategory.fromJson(Map<String, dynamic> json) {
    return ArticleCategory(
      id: json['id'] as int? ?? 0, // Using ?? for default value
      categoryName: json['categoryName'] as String? ?? '',
      categoryNameRu: json['categoryNameRu'] as String? ?? '',
      imgUrl: json['imgUrl'] as String? ?? '',
      code: json['code'] as String? ?? '',
      colorCode: json['colorCode'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    // Added toJson method
    return <String, dynamic>{
      'id': id,
      'categoryName': categoryName,
      'categoryNameRu': categoryNameRu,
      'imgUrl': imgUrl,
      'code': code,
      'colorCode': colorCode,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    // Implemented Equatable props
    id,
    categoryName,
    categoryNameRu,
    imgUrl,
    code,
    colorCode,
  ];

  ArticleCategory copyWith({
    // Added copyWith method
    int? id,
    String? categoryName,
    String? categoryNameRu,
    String? imgUrl,
    String? code,
    String? colorCode,
  }) {
    return ArticleCategory(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      categoryNameRu: categoryNameRu ?? this.categoryNameRu,
      imgUrl: imgUrl ?? this.imgUrl,
      code: code ?? this.code,
      colorCode: colorCode ?? this.colorCode,
    );
  }

  String getCategoryName(String languageCode) {
    return languageCode == "ru" ? categoryNameRu : categoryName;
  }
}
