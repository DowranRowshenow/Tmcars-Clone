import 'package:equatable/equatable.dart';

class ArticleDetail extends Equatable {
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
  final DateTime publishedDate3;
  final DateTime lastUpdated;
  final String elapsedTime;
  final String elapsedTimeRu;
  final String img;
  final List<ArticleImage> imgs;
  final String shareSiteUrl;
  final String shareSiteUrlRu;
  final String? shareUrl;
  final String? shareUrlRu;
  final List<ArticleTag> tags;
  final int viewCount;

  const ArticleDetail({
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
      imgs:
          (json['imgs'] as List<dynamic>?)
              ?.map((e) => ArticleImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      shareSiteUrl: json['shareSiteUrl'] as String,
      shareSiteUrlRu: json['shareSiteUrlRu'] as String,
      shareUrl: json['shareUrl'] as String?,
      shareUrlRu: json['shareUrlRu'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)
              ?.map((e) => ArticleTag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
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
  List<Object?> get props => [
    id,
    title,
    titleRu,
    openUrlRu,
    openUrl,
    categoryName,
    categoryNameRu,
    categoryId,
    categoryCode,
    publishedDate,
    publishedDate3,
    lastUpdated,
    elapsedTime,
    elapsedTimeRu,
    img,
    imgs,
    shareSiteUrl,
    shareSiteUrlRu,
    shareUrl,
    shareUrlRu,
    tags,
    viewCount,
  ];

  ArticleDetail copyWith({
    int? id,
    String? title,
    String? titleRu,
    String? openUrlRu,
    String? openUrl,
    String? categoryName,
    String? categoryNameRu,
    int? categoryId,
    String? categoryCode,
    DateTime? publishedDate,
    DateTime? publishedDate3,
    DateTime? lastUpdated,
    String? elapsedTime,
    String? elapsedTimeRu,
    String? img,
    List<ArticleImage>? imgs,
    String? shareSiteUrl,
    String? shareSiteUrlRu,
    String? shareUrl,
    String? shareUrlRu,
    List<ArticleTag>? tags,
    int? viewCount,
  }) {
    return ArticleDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      titleRu: titleRu ?? this.titleRu,
      openUrlRu: openUrlRu ?? this.openUrlRu,
      openUrl: openUrl ?? this.openUrl,
      categoryName: categoryName ?? this.categoryName,
      categoryNameRu: categoryNameRu ?? this.categoryNameRu,
      categoryId: categoryId ?? this.categoryId,
      categoryCode: categoryCode ?? this.categoryCode,
      publishedDate: publishedDate ?? this.publishedDate,
      publishedDate3: publishedDate3 ?? this.publishedDate3,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      elapsedTimeRu: elapsedTimeRu ?? this.elapsedTimeRu,
      img: img ?? this.img,
      imgs: imgs ?? this.imgs,
      shareSiteUrl: shareSiteUrl ?? this.shareSiteUrl,
      shareSiteUrlRu: shareSiteUrlRu ?? this.shareSiteUrlRu,
      shareUrl: shareUrl ?? this.shareUrl,
      shareUrlRu: shareUrlRu ?? this.shareUrlRu,
      tags: tags ?? this.tags,
      viewCount: viewCount ?? this.viewCount,
    );
  }

  List<String> getImageUrls({bool isThumbnail = false}) {
    return isThumbnail
        ? imgs.map((image) => image.thumbnail).toList()
        : imgs.map((image) => image.original).toList();
  }
}

class ArticleImage extends Equatable {
  final String thumbnail;
  final String original;

  const ArticleImage({required this.thumbnail, required this.original});

  factory ArticleImage.fromJson(Map<String, dynamic> json) {
    return ArticleImage(
      thumbnail: json['thumbnail'] as String,
      original: json['original'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'thumbnail': thumbnail, 'original': original};
  }

  @override
  List<Object> get props => [thumbnail, original];

  ArticleImage copyWith({String? thumbnail, String? original}) {
    return ArticleImage(
      thumbnail: thumbnail ?? this.thumbnail,
      original: original ?? this.original,
    );
  }
}

class ArticleTag extends Equatable {
  final String code;
  final String name;
  final String nameRu;

  const ArticleTag({
    required this.code,
    required this.name,
    required this.nameRu,
  });

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

  @override
  List<Object> get props => [code, name, nameRu];

  ArticleTag copyWith({String? code, String? name, String? nameRu}) {
    return ArticleTag(
      code: code ?? this.code,
      name: name ?? this.name,
      nameRu: nameRu ?? this.nameRu,
    );
  }
}
