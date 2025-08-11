import 'package:flutter/material.dart';

import '../../../models/car_detail_model.dart';
import '../../../providers/themes.dart';

Widget _buildKeyValueRow(
  BuildContext context,
  String key,
  String value, {
  bool? isTrue,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            " $key",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(
                context,
              ).extension<AppColors>()!.textHintThemeColor,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              isTrue != null
                  ? isTrue
                        ? const Icon(
                            Icons.check_circle,
                            size: 14,
                            color: Colors.green,
                          )
                        : const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 6,
                            child: Icon(
                              Icons.close,
                              size: 12,
                              color: Colors.white,
                            ),
                          )
                  : const SizedBox.shrink(),
              Flexible(
                child: Text(
                  isTrue != null ? " $value" : value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildbody(
  BuildContext context,
  CarDetail carDetail,
  String languageCode,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Row(
          children: <Widget>[
            Icon(Icons.info, size: 32),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                "Giňişleýin maglumat",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        _buildKeyValueRow(context, "Modeli", "${carDetail.bn} ${carDetail.mn}"),
        _buildKeyValueRow(context, "Ýyly", carDetail.y.toString()),
        _buildKeyValueRow(context, "Probeg", carDetail.mil.toString()),
        _buildKeyValueRow(context, "Reňki", carDetail.getColor(languageCode)),
        _buildKeyValueRow(context, "Motory", carDetail.e.toString()),
        _buildKeyValueRow(context, "Kuzow", carDetail.bt),
        _buildKeyValueRow(context, "Karobka", carDetail.tt),
        _buildKeyValueRow(context, "Ýörediji görnüşi", carDetail.driveType),
        _buildKeyValueRow(context, "VIN kod", carDetail.vin ?? "-"),
        _buildKeyValueRow(context, "Bahasy", "${carDetail.pr.toString()} TMT"),
        _buildKeyValueRow(context, "Ýeri", carDetail.getCityName(languageCode)),
        _buildKeyValueRow(
          context,
          "Kredit",
          carDetail.cr ? "Hawa" : "Ýok",
          isTrue: carDetail.cr,
        ),
        _buildKeyValueRow(
          context,
          "Obmen",
          carDetail.sw ? "Hawa" : "Ýok",
          isTrue: carDetail.sw,
        ),
        _buildKeyValueRow(
          context,
          "Goýuldy",
          carDetail.getPublishedDate(languageCode),
        ),
        _buildKeyValueRow(context, "Satyjy nomeri", "+${carDetail.pn ?? ''}"),
        const SizedBox(height: 10),
        Container(
          color: Colors.grey.withAlpha(70),
          height: 180,
          child: Container(),
        ),
        const SizedBox(height: 20),
        Text(
          carDetail.dsc,
          style: TextStyle(
            color: Theme.of(context).extension<AppColors>()!.textHintThemeColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () {},
          overlayColor: WidgetStateProperty.all(Colors.grey),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.grey,
            width: double.infinity,
            child: const Center(
              child: Text(
                "Nägilelik bildirmek",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text("Biznes hasaplar"),
        const SizedBox(height: 20),
        SizedBox(
          height: 200, // Provides a fixed height for the horizontal grid
          child: GridView.count(
            scrollDirection: Axis.horizontal,
            crossAxisCount: 2,
            children: List<Widget>.generate(
              10, // Provide some widgets to display in the grid
              (int index) => Container(
                alignment: Alignment.center,
                color: Colors.grey[200],
                margin: const EdgeInsets.all(4),
                child: Text(
                  'Grid Item $index',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    ),
  );
}
