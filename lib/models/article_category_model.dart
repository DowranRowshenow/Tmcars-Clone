class ArticleCategory {
  final int id;
  final String categoryName;
  final String categoryNameRu;
  final String imgUrl;
  final String code;
  final String colorCode;

  ArticleCategory({
    required this.id,
    required this.categoryName,
    required this.categoryNameRu,
    required this.imgUrl,
    required this.code,
    required this.colorCode,
  });

  factory ArticleCategory.fromJson(Map<String, dynamic> json) {
    return ArticleCategory(
      id: json['id'],
      categoryName: json['categoryName'],
      categoryNameRu: json['categoryNameRu'],
      imgUrl: json['imgUrl'],
      code: json['code'],
      colorCode: json['colorCode'],
    );
  }
}
