import 'package:flutter/material.dart';

import '../../../models/car_detail_model.dart';
import '../../../models/car_model.dart';
import '../../../providers/themes.dart';
import 'car_detail_body.dart';
import 'car_detail_header.dart';

class CarDetailContent extends StatelessWidget {
  final CarDetail carDetail;
  final Car car;
  final String languageCode;

  const CarDetailContent({
    super.key,
    required this.carDetail,
    required this.car,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildheader(context, carDetail, languageCode),
        Container(
          height: 16,
          color: Theme.of(context).extension<AppColors>()!.tileThemeColor,
        ),
        buildbody(context, carDetail, languageCode),
      ],
    );
  }
}
