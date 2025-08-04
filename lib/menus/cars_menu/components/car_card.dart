// THIS CUSTOM WIDGETS USAGE FREQUENCY IS {HIGH} AND {DYNAMIC}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/car_model.dart';
import '../../../providers/locale.dart';
import '../../../providers/themes.dart';
import 'car_card_image.dart';

class CarCard extends StatelessWidget {
  const CarCard({super.key, required this.car, this.imageWidth});
  final Car car;
  final double? imageWidth;

  @override
  Widget build(BuildContext context) {
    final Locale locale = context.read<LocaleManager>().locale;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final AppLocalizations appLocalizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: appColors.dividerColor!, width: 1),
        ),
      ),
      child: ListTile(
        minVerticalPadding: 0,
        // minTileHeight: Constants.articleItemExtent,
        contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        onTap: () {
          /*
          context.read<NavigationManager>().setScreen(
            context,
            ScreenState.carDetail,
            car: car,
          );
          */
        },
        titleAlignment: ListTileTitleAlignment.center,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CarCardImage(img: car.imgSmall, width: imageWidth),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${car.brandName} ${car.modelName} ${car.year}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${car.getCityName(locale.languageCode)} ${car.elapsedTime ?? ''}",
                    maxLines: 1,
                    textWidthBasis: TextWidthBasis.parent,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 12,
                      color: appColors.textHintThemeColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${car.price} TMT",
                    maxLines: 1,
                    textWidthBasis: TextWidthBasis.parent,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 12,
                      color: appColors.textHintThemeColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(appLocalizations.credit),
                      const SizedBox(width: 2),
                      car.isCredit!
                          ? const Icon(
                              Icons.check_circle,
                              size: 16,
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
                            ),
                      const SizedBox(width: 8),
                      Text(appLocalizations.exchange),
                      const SizedBox(width: 2),
                      car.isSwap!
                          ? const Icon(
                              Icons.check_circle,
                              size: 16,
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
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
