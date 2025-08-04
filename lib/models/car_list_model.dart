import 'package:equatable/equatable.dart';

import 'car_model.dart';

class CarList extends Equatable {
  final List<Car> cars;
  final int totalCount;
  final Map<String, dynamic> facelets;
  final bool skippedItems;
  final int loadTime;

  const CarList({
    required this.cars,
    required this.totalCount,
    required this.facelets,
    required this.skippedItems,
    required this.loadTime,
  });

  factory CarList.fromJson(Map<String, dynamic> json, {bool isV2 = false}) {
    return CarList(
      cars:
          (json['cars'] as List<dynamic>?)?.map((dynamic e) {
            return isV2
                ? Car.fromJsonV2(e as Map<String, dynamic>)
                : Car.fromJson(e as Map<String, dynamic>);
          }).toList() ??
          <Car>[],
      totalCount: json['totalCount'] as int? ?? 0,
      facelets:
          json['facelets'] as Map<String, dynamic>? ?? <String, dynamic>{},
      skippedItems: json['skippedItems'] as bool? ?? false,
      loadTime: json['loadTime'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'cars': cars.map((Car e) => e.toJson()).toList(),
      'totalCount': totalCount,
      'facelets': facelets,
      'skippedItems': skippedItems,
      'loadTime': loadTime,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    cars,
    totalCount,
    facelets,
    skippedItems,
    loadTime,
  ];
}
