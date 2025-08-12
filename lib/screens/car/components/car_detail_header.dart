import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/car_detail_model.dart';
import '../../../providers/themes.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';

Widget buildheader(
  BuildContext context,
  CarDetail carDetail,
  String languageCode,
) {
  return Container(
    padding: const EdgeInsets.fromLTRB(
      Constants.detailHorizontalPadding,
      30,
      Constants.detailHorizontalPadding,
      20,
    ),
    decoration: BoxDecoration(
      gradient: carDetail.vip
          ? context.read<ThemeManager>().isDark()
                ? const LinearGradient(
                    colors: <Color>[
                      Colors.white10,
                      Colors.transparent,
                      Color.fromARGB(255, 58, 66, 83),
                    ],
                  )
                : const LinearGradient(
                    stops: <double>[0.2, 0.75, 1.0],
                    colors: <Color>[
                      Color.fromARGB(255, 255, 255, 104),
                      Color.fromARGB(255, 224, 255, 112),
                      Colors.white,
                    ],
                  )
          : null,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          carDetail.getTitle(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          "${carDetail.pr.toString()} TMT",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          carDetail.getCityName(languageCode),
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Icon(
              Icons.calendar_today,
              size: 16,
              color: Theme.of(context).extension<AppColors>()!.iconThemeColor,
            ),
            const SizedBox(width: 4),
            Builder(
              builder: (BuildContext context) {
                return Flexible(
                  child: Text(
                    carDetail.getPublishedDate(languageCode),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(
                        context,
                      ).extension<AppColors>()!.iconThemeColor,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            Icon(
              Icons.visibility,
              size: 16,
              color: Theme.of(context).extension<AppColors>()!.iconThemeColor,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                carDetail.vc.toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(
                    context,
                  ).extension<AppColors>()!.iconThemeColor,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
