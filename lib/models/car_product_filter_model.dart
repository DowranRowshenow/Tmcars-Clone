import 'package:equatable/equatable.dart';

class CarProductFilter extends Equatable {
  final int? id;
  final String? filterName;
  final String? filterNameRu;
  final int? priceStart;
  final int? priceEnd;
  final String? cityName;
  final String? brandName;
  final int? brandId;
  final List<String>? modelNames;
  final int? yearStart;
  final int? yearEnd;
  final bool? isSwap;
  final bool? isCredit;
  final String? imgUrl;
  final int? productCount;
  final bool? onlyBrand;
  final int? partCategoryId;
  final String? partCategoryName;
  final String? partCategoryNameRu;
  final int? partTypeId;
  final String? partTypeName;
  final String? partTypeNameRu;

  const CarProductFilter({
    this.id,
    this.filterName,
    this.filterNameRu,
    this.priceStart,
    this.priceEnd,
    this.cityName,
    this.brandName,
    this.brandId,
    this.modelNames,
    this.yearStart,
    this.yearEnd,
    this.isSwap,
    this.isCredit,
    this.imgUrl,
    this.productCount,
    this.onlyBrand,
    this.partCategoryId,
    this.partCategoryName,
    this.partCategoryNameRu,
    this.partTypeId,
    this.partTypeName,
    this.partTypeNameRu,
  });

  factory CarProductFilter.fromJson(Map<String, dynamic> json) {
    return CarProductFilter(
      id: json['id'] as int? ?? 0,
      filterName: json['filterName'] as String?,
      filterNameRu: json['filterNameRu'] as String?,
      priceStart: json['priceStart'] as int?,
      priceEnd: json['priceEnd'] as int?,
      cityName: json['cityName'] as String?,
      brandName: json['brandName'] as String?,
      brandId: json['brandId'] as int?,
      modelNames: (json['modelNames'] as List<dynamic>?)
          ?.map((dynamic e) => e as String)
          .toList(),
      yearStart: json['yearStart'] as int?,
      yearEnd: json['yearEnd'] as int?,
      isSwap: json['isSwap'] as bool?,
      isCredit: json['isCredit'] as bool?,
      imgUrl: json['imgUrl'] as String?,
      productCount: json['productCount'] as int?,
      onlyBrand: json['onlyBrand'] as bool?,
      partCategoryId: json['partCategoryId'] as int?,
      partCategoryName: json['partCategoryName'] as String?,
      partCategoryNameRu: json['partCategoryNameRu'] as String?,
      partTypeId: json['partTypeId'] as int?,
      partTypeName: json['partTypeName'] as String?,
      partTypeNameRu: json['partTypeNameRu'] as String?,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    filterName,
    filterNameRu,
    priceStart,
    priceEnd,
    cityName,
    brandName,
    brandId,
    modelNames,
    yearStart,
    yearEnd,
    isSwap,
    isCredit,
    imgUrl,
    productCount,
    onlyBrand,
    partCategoryId,
    partCategoryName,
    partCategoryNameRu,
    partTypeId,
    partTypeName,
    partTypeNameRu,
  ];

  Map<String, String> map() {
    Map<String, String> map = <String, String>{};
    if (id != null) {
      map['id'] = id.toString();
    }
    if (filterName != null) {
      map['offset'] = filterName.toString();
    }
    if (brandName != null) {
      map['brandName'] = brandName!;
    }
    if (brandId != null) {
      map['brandId'] = brandId!.toString();
    }
    if (imgUrl != null) {
      map['imgUrl'] = imgUrl!;
    }
    if (productCount != null) {
      map['productCount'] = productCount!.toString();
    }
    if (onlyBrand != null) {
      map['onlyBrand'] = onlyBrand!.toString();
    }
    return map;
  }

  String? getFilterName(String languageCode) {
    return languageCode == "ru" ? filterNameRu : filterName;
  }

  String? getPartCategoryName(String languageCode) {
    return languageCode == "ru" ? partCategoryNameRu : partCategoryName;
  }

  String? getPartTypeName(String languageCode) {
    return languageCode == "ru" ? partTypeNameRu : partTypeName;
  }
}
