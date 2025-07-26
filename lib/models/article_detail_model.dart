class ArticleDetail {
  final int id;
  final String title;
  final String titleRu;
  final String openUrlRu;
  final String openUrl;
  final String categoryName;
  final String categoryNameRu;
  final int categoryId;
  final String categoryCode;
  final DateTime publishedDate;
  final DateTime publishedDate3; // Appears to be a duplicate of publishedDate
  final DateTime lastUpdated;
  final String elapsedTime;
  final String elapsedTimeRu;
  final String img;
  final List<ArticleImage> imgs;
  final String shareSiteUrl;
  final String shareSiteUrlRu;
  final String? shareUrl; // Can be null
  final String? shareUrlRu; // Can be null
  final List<ArticleTag> tags;
  final int viewCount;

  ArticleDetail({
    required this.id,
    required this.title,
    required this.titleRu,
    required this.openUrlRu,
    required this.openUrl,
    required this.categoryName,
    required this.categoryNameRu,
    required this.categoryId,
    required this.categoryCode,
    required this.publishedDate,
    required this.publishedDate3,
    required this.lastUpdated,
    required this.elapsedTime,
    required this.elapsedTimeRu,
    required this.img,
    required this.imgs,
    required this.shareSiteUrl,
    required this.shareSiteUrlRu,
    this.shareUrl,
    this.shareUrlRu,
    required this.tags,
    required this.viewCount,
  });

  factory ArticleDetail.fromJson(Map<String, dynamic> json) {
    return ArticleDetail(
      id: json['id'] as int,
      title: json['title'] as String,
      titleRu: json['titleRu'] as String,
      openUrlRu: json['openUrlRu'] as String,
      openUrl: json['openUrl'] as String,
      categoryName: json['categoryName'] as String,
      categoryNameRu: json['categoryNameRu'] as String,
      categoryId: json['categoryId'] as int,
      categoryCode: json['categoryCode'] as String,
      publishedDate: DateTime.parse(json['publishedDate'] as String),
      publishedDate3: DateTime.parse(json['publishedDate3'] as String),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      elapsedTime: json['elapsedTime'] as String,
      elapsedTimeRu: json['elapsedTimeRu'] as String,
      img: json['img'] as String,
      imgs: (json['imgs'] as List<dynamic>)
          .map((e) => ArticleImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      shareSiteUrl: json['shareSiteUrl'] as String,
      shareSiteUrlRu: json['shareSiteUrlRu'] as String,
      shareUrl: json['shareUrl'] as String?, // Nullable
      shareUrlRu: json['shareUrlRu'] as String?, // Nullable
      tags: (json['tags'] as List<dynamic>)
          .map((e) => ArticleTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      viewCount: json['viewCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'titleRu': titleRu,
      'openUrlRu': openUrlRu,
      'openUrl': openUrl,
      'categoryName': categoryName,
      'categoryNameRu': categoryNameRu,
      'categoryId': categoryId,
      'categoryCode': categoryCode,
      'publishedDate': publishedDate.toIso8601String(),
      'publishedDate3': publishedDate3.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'elapsedTime': elapsedTime,
      'elapsedTimeRu': elapsedTimeRu,
      'img': img,
      'imgs': imgs.map((e) => e.toJson()).toList(),
      'shareSiteUrl': shareSiteUrl,
      'shareSiteUrlRu': shareSiteUrlRu,
      'shareUrl': shareUrl,
      'shareUrlRu': shareUrlRu,
      'tags': tags.map((e) => e.toJson()).toList(),
      'viewCount': viewCount,
    };
  }

  @override
  String toString() {
    return 'ArticleDetail(id: $id, title: $title, categoryName: $categoryName, viewCount: $viewCount)';
  }
}

class ArticleImage {
  final String thumbnail;
  final String original;

  ArticleImage({required this.thumbnail, required this.original});

  factory ArticleImage.fromJson(Map<String, dynamic> json) {
    return ArticleImage(
      thumbnail: json['thumbnail'] as String,
      original: json['original'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'thumbnail': thumbnail, 'original': original};
  }
}

class ArticleTag {
  final String code;
  final String name;
  final String nameRu;

  ArticleTag({required this.code, required this.name, required this.nameRu});

  factory ArticleTag.fromJson(Map<String, dynamic> json) {
    return ArticleTag(
      code: json['code'] as String,
      name: json['name'] as String,
      nameRu: json['nameRu'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'name': name, 'nameRu': nameRu};
  }
}
