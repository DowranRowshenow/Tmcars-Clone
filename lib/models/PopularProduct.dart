// ignore_for_file: file_names

class PopularProduct {
  final int id;
  final int activeAdvId;
  final int productId;
  final String img;
  final String description;
  final String descriptionRu;
  final String timeLocation;
  final String timeLocationRu;
  final bool vip;
  final int p;
  final String type;
  final String title;

  PopularProduct({
    required this.id,
    required this.activeAdvId,
    required this.productId,
    required this.img,
    required this.description,
    required this.descriptionRu,
    required this.timeLocation,
    required this.timeLocationRu,
    required this.vip,
    required this.p,
    required this.type,
    required this.title,
  });

  factory PopularProduct.fromJson(Map<String, dynamic> json) {
    return PopularProduct(
      id: json['id'] as int,
      activeAdvId: json['activeAdvId'] as int,
      productId: json['productId'] as int,
      img: json['img'] as String,
      description: json['description'] as String,
      descriptionRu: json['descriptionRu'] as String,
      timeLocation: json['timeLocation'] as String,
      timeLocationRu: json['timeLocationRu'] as String,
      vip: json['vip'] as bool,
      p: json['p'] as int,
      type: json['type'] as String,
      title: json['title'] as String,
    );
  }
}
