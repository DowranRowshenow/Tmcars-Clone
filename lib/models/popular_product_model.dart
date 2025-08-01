import 'package:equatable/equatable.dart'; // Added for Equatable

class PopularProduct extends Equatable {
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

  const PopularProduct({
    // Made constructor const
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

  Map<String, dynamic> toJson() {
    // Added toJson method
    return <String, dynamic>{
      'id': id,
      'activeAdvId': activeAdvId,
      'productId': productId,
      'img': img,
      'description': description,
      'descriptionRu': descriptionRu,
      'timeLocation': timeLocation,
      'timeLocationRu': timeLocationRu,
      'vip': vip,
      'p': p,
      'type': type,
      'title': title,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    // Implemented Equatable props
    id,
    activeAdvId,
    productId,
    img,
    description,
    descriptionRu,
    timeLocation,
    timeLocationRu,
    vip,
    p,
    type,
    title,
  ];

  PopularProduct copyWith({
    // Added copyWith method
    int? id,
    int? activeAdvId,
    int? productId,
    String? img,
    String? description,
    String? descriptionRu,
    String? timeLocation,
    String? timeLocationRu,
    bool? vip,
    int? p,
    String? type,
    String? title,
  }) {
    return PopularProduct(
      id: id ?? this.id,
      activeAdvId: activeAdvId ?? this.activeAdvId,
      productId: productId ?? this.productId,
      img: img ?? this.img,
      description: description ?? this.description,
      descriptionRu: descriptionRu ?? this.descriptionRu,
      timeLocation: timeLocation ?? this.timeLocation,
      timeLocationRu: timeLocationRu ?? this.timeLocationRu,
      vip: vip ?? this.vip,
      p: p ?? this.p,
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }
}
