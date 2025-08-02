import 'package:equatable/equatable.dart'; // Added for Equatable

class Article extends Equatable {
  final int id;
  final int viewCount;
  final String title;
  final String titleRu;
  final String openUrl;
  final String openUrlRu;
  final String categoryName;
  final String categoryNameRu;
  final String publishedDate;
  final String publishedDate3;
  final String elapsedTime;
  final String elapsedTimeRu;
  final String img;
  final bool? videoExist;

  const Article({
    // Made constructor const
    required this.id,
    required this.viewCount,
    required this.title,
    required this.titleRu,
    required this.openUrl,
    required this.openUrlRu,
    required this.categoryName,
    required this.categoryNameRu,
    required this.publishedDate,
    required this.publishedDate3,
    required this.elapsedTime,
    required this.elapsedTimeRu,
    required this.img,
    this.videoExist,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int? ?? 0, // Using ?? for default value
      viewCount: json['viewCount'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      titleRu: json['titleRu'] as String? ?? '',
      openUrl: json['openUrl'] as String? ?? '',
      openUrlRu: json['openUrlRu'] as String? ?? '',
      categoryName: json['categoryName'] as String? ?? '',
      categoryNameRu: json['categoryNameRu'] as String? ?? '',
      publishedDate: json['publishedDate'] as String? ?? '',
      publishedDate3: json['publishedDate3'] as String? ?? '',
      elapsedTime: json['elapsedTime'] as String? ?? '',
      elapsedTimeRu: json['elapsedTimeRu'] as String? ?? '',
      img: json['img'] as String? ?? '',
      videoExist: json['videoExist'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'viewCount': viewCount,
      'title': title,
      'titleRu': titleRu,
      'openUrl': openUrl,
      'openUrlRu': openUrlRu,
      'categoryName': categoryName,
      'categoryNameRu': categoryNameRu,
      'publishedDate': publishedDate,
      'publishedDate3': publishedDate3,
      'elapsedTime': elapsedTime,
      'elapsedTimeRu': elapsedTimeRu,
      'img': img,
      'videoExist': videoExist,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    // Implemented Equatable props
    id,
    viewCount,
    title,
    titleRu,
    openUrl,
    openUrlRu,
    categoryName,
    categoryNameRu,
    publishedDate,
    publishedDate3,
    elapsedTime,
    elapsedTimeRu,
    img,
    videoExist,
  ];

  Article copyWith({
    // Added copyWith method
    int? id,
    int? viewCount,
    String? title,
    String? titleRu,
    String? openUrl,
    String? openUrlRu,
    String? categoryName,
    String? categoryNameRu,
    String? publishedDate,
    String? publishedDate3,
    String? elapsedTime,
    String? elapsedTimeRu,
    String? img,
    bool? videoExist,
  }) {
    return Article(
      id: id ?? this.id,
      viewCount: viewCount ?? this.viewCount,
      title: title ?? this.title,
      titleRu: titleRu ?? this.titleRu,
      openUrl: openUrl ?? this.openUrl,
      openUrlRu: openUrlRu ?? this.openUrlRu,
      categoryName: categoryName ?? this.categoryName,
      categoryNameRu: categoryNameRu ?? this.categoryNameRu,
      publishedDate: publishedDate ?? this.publishedDate,
      publishedDate3: publishedDate3 ?? this.publishedDate3,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      elapsedTimeRu: elapsedTimeRu ?? this.elapsedTimeRu,
      img: img ?? this.img,
      videoExist: videoExist ?? this.videoExist,
    );
  }

  String getTitle(String languageCode) {
    return languageCode == "ru" ? titleRu : title;
  }

  String getOpenUrl(String languageCode) {
    return languageCode == "ru" ? openUrlRu : openUrl;
  }

  String getElapsedTime(String languageCode) {
    return languageCode == "ru" ? elapsedTimeRu : elapsedTime;
  }

  String getCategoryName(String languageCode) {
    return languageCode == "ru" ? categoryNameRu : categoryName;
  }
}
