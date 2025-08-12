import 'package:flutter/material.dart';
import 'package:tmcarsclone/l10n/app_localizations.dart';

import '../../../models/car_detail_model.dart';
import '../../../utils/app_colors.dart';

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
  final AppLocalizations appLocalizations = Localizations.of<AppLocalizations>(
    context,
    AppLocalizations,
  )!;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.info, size: 32),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                appLocalizations.moreInformation,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        _buildKeyValueRow(
          context,
          appLocalizations.model,
          "${carDetail.bn} ${carDetail.mn}",
        ),
        _buildKeyValueRow(
          context,
          appLocalizations.year,
          carDetail.y.toString(),
        ),
        _buildKeyValueRow(
          context,
          appLocalizations.mileage,
          carDetail.mil.toString(),
        ),
        _buildKeyValueRow(
          context,
          appLocalizations.color,
          carDetail.getColor(languageCode),
        ),
        _buildKeyValueRow(
          context,
          appLocalizations.engine,
          carDetail.e.toString(),
        ),
        _buildKeyValueRow(context, appLocalizations.body, carDetail.bt),
        _buildKeyValueRow(context, appLocalizations.gearbox, carDetail.tt),
        _buildKeyValueRow(
          context,
          appLocalizations.drivetrain,
          carDetail.driveType,
        ),
        _buildKeyValueRow(context, appLocalizations.vin, carDetail.vin ?? "-"),
        _buildKeyValueRow(
          context,
          appLocalizations.price,
          "${carDetail.pr.toString()} TMT",
        ),
        _buildKeyValueRow(
          context,
          appLocalizations.location,
          carDetail.getCityName(languageCode),
        ),
        _buildKeyValueRow(
          context,
          appLocalizations.credit,
          carDetail.cr ? appLocalizations.yes : appLocalizations.no,
          isTrue: carDetail.cr,
        ),
        _buildKeyValueRow(
          context,
          appLocalizations.exchange,
          carDetail.sw ? appLocalizations.yes : appLocalizations.no,
          isTrue: carDetail.sw,
        ),
        _buildKeyValueRow(
          context,
          appLocalizations.published,
          carDetail.getPublishedDate(languageCode),
        ),
        _buildKeyValueRow(
          context,
          appLocalizations.sellerPhoneNumber,
          "+${carDetail.pn ?? ''}",
        ),
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
            child: Center(
              child: Text(
                appLocalizations.report,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(appLocalizations.businessProfiles),
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
                color: Colors.black45,
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
