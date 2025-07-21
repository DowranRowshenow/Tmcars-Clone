class Article {
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

  Article({
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
      id: json['id'],
      viewCount: json['viewCount'],
      title: json['title'],
      titleRu: json['titleRu'],
      openUrl: json['openUrl'],
      openUrlRu: json['openUrlRu'],
      categoryName: json['categoryName'],
      categoryNameRu: json['categoryNameRu'],
      publishedDate: json['publishedDate'],
      publishedDate3: json['publishedDate3'],
      elapsedTime: json['elapsedTime'],
      elapsedTimeRu: json['elapsedTimeRu'],
      img: json['img'],
      videoExist: json['videoExist'],
    );
  }
}
