import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';

class Car extends Equatable {
  final int id;
  final String? cityName;
  final String? cityNameRu;
  final String brandName;
  final String modelName;
  final String? trim;
  final int year;
  final bool? isSwap;
  final bool? isCredit;
  final bool? isSold;
  final bool? vip;
  final String? generationId;
  final int price;
  final String? publishedDate;
  final String? elapsedTime;
  final String? imgSmall;
  final bool? invisible;
  final bool? vinCheck;
  final bool? toMe;

  const Car({
    required this.id,
    this.cityName,
    this.cityNameRu,
    required this.brandName,
    required this.modelName,
    this.trim,
    required this.year,
    this.isSwap,
    this.isCredit,
    this.isSold,
    this.vip,
    this.generationId,
    required this.price,
    this.publishedDate,
    this.elapsedTime,
    this.imgSmall,
    this.invisible,
    this.vinCheck,
    this.toMe,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as int? ?? 0,
      cityName: json['cityName'] as String? ?? "",
      cityNameRu: json['cityNameRu'] as String? ?? "",
      brandName: json['brandName'] as String? ?? "",
      modelName: json['modelName'] as String? ?? "",
      trim: json['trim'] as String? ?? "",
      year: json['year'] as int? ?? 0,
      isSwap: json['isSwap'] as bool? ?? false,
      isCredit: json['isCredit'] as bool? ?? false,
      isSold: json['isSold'] as bool? ?? false,
      vip: json['vip'] as bool? ?? false,
      generationId: json['generationId'] as String? ?? "",
      price: json['price'] as int? ?? 0,
      publishedDate: json['publishedDate'] as String? ?? "",
      elapsedTime: json['elapsedTime'] as String? ?? "",
      imgSmall: json['imgSmall'] as String? ?? "",
      invisible: json['invisible'] as bool? ?? false,
      vinCheck: json['vinCheck'] as bool? ?? false,
      toMe: json['toMe'] as bool? ?? false,
    );
  }

  factory Car.fromJsonV2(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as int? ?? 0,
      cityName: json['cn'] as String? ?? "",
      cityNameRu: json['cnru'] as String? ?? "",
      brandName: json['bn'] as String? ?? '',
      modelName: json['mn'] as String? ?? '',
      trim: json['trim'] as String? ?? "",
      year: json['y'] as int? ?? 0,
      isSwap: json['sw'] as bool? ?? false,
      isCredit: json['cr'] as bool? ?? false,
      isSold: json['sd'] as bool? ?? false,
      vip: json['vip'] as bool? ?? false,
      generationId: json['gid'] as String? ?? "",
      price: json['pr'] as int? ?? 0,
      publishedDate: json['pd'] as String? ?? "",
      elapsedTime: json['et'] as String? ?? "",
      imgSmall: json['img'] as String? ?? "",
      invisible: json['inv'] as bool? ?? false,
      vinCheck: json['vic'] as bool? ?? false,
      toMe: json['toMe'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJsonV2() {
    return <String, dynamic>{
      'id': id,
      'cn': cityName,
      'cnru': cityNameRu,
      'bn': brandName,
      'mn': modelName,
      'trim': trim,
      'y': year,
      'sw': isSwap,
      'cr': isCredit,
      'sd': isSold,
      'vip': vip,
      'gid': generationId,
      'pr': price,
      'pd': publishedDate,
      'et': elapsedTime,
      'img': imgSmall,
      'inv': invisible,
      'vic': vinCheck,
      'toMe': toMe,
    };
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'cityName': cityName,
      'cityNameRu': cityNameRu,
      'brandName': brandName,
      'modelName': modelName,
      'trim': trim,
      'year': year,
      'isSwap': isSwap,
      'isCredit': isCredit,
      'isSold': isSold,
      'vip': vip,
      'generationId': generationId,
      'price': price,
      'publishedDate': publishedDate,
      'elapsedTime': elapsedTime,
      'imgSmall': imgSmall,
      'invisible': invisible,
      'vinCheck': vinCheck,
      'toMe': toMe,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    cityName,
    cityNameRu,
    brandName,
    modelName,
    trim,
    year,
    isSwap,
    isCredit,
    isSold,
    vip,
    generationId,
    price,
    publishedDate,
    elapsedTime,
    imgSmall,
    invisible,
    vinCheck,
    toMe,
  ];

  String? getCityName(String languageCode) {
    return languageCode == "ru" ? cityNameRu : cityName;
  }

  String getTitle() {
    return "$brandName $modelName $year";
  }

  String getPublishedDate(String languageCode) {
    return DateFormat(
      Constants.dateFormat,
      languageCode,
    ).format(DateTime.parse(publishedDate ?? "")).toString();
  }
}
