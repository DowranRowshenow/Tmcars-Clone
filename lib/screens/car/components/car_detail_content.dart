import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/car_detail_model.dart';
import '../../../models/car_model.dart';

class CarDetailContent extends StatelessWidget {
  final CarDetail? carDetail;
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
        const SizedBox(height: 20),
        Text(
          carDetail?.getTitle() ?? "",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              DateFormat(
                'dd MMMM yyyy',
                'tk',
              ).format(DateTime.parse(car.publishedDate ?? "")),
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.visibility, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              carDetail?.vc.toString() ?? "",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 30),
        // Placeholder for an ad or other content
        Container(
          height: 80,
          width: double.infinity,
          color: Colors.grey.withAlpha(70),
        ),
        const SizedBox(height: 10),
        Container(
          color: Colors.grey.withAlpha(70),
          height: 180,
          child: Container(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
