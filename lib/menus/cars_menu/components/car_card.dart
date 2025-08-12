// THIS CUSTOM WIDGETS USAGE FREQUENCY IS {HIGH} AND {DYNAMIC}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/car_model.dart';
import '../../../providers/locale.dart';
import '../../../providers/navigation.dart';
import '../../../providers/themes.dart';
import '../../../utils/app_colors.dart';
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
        gradient: car.vip ?? false
            ? context.read<ThemeManager>().isDark()
                  ? const LinearGradient(
                      stops: <double>[0.2, 0.3, 1.0],
                      colors: <Color>[
                        Colors.white10,
                        Colors.transparent,
                        Color.fromARGB(255, 58, 66, 83),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : const LinearGradient(
                      stops: <double>[0.2, 0.75, 1.0],
                      colors: <Color>[
                        Color.fromARGB(255, 255, 255, 104),
                        Color.fromARGB(255, 224, 255, 112),
                        Colors.white,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
            : null,
        border: Border(
          bottom: BorderSide(color: appColors.dividerColor!, width: 1),
        ),
      ),
      child: ListTile(
        hoverColor: Colors.black12,
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        onTap: () {
          context.read<NavigationManager>().setScreen(
            context,
            ScreenState.carDetail,
            car: car,
          );
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
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
                  const SizedBox(height: 6),
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
                  const SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          appLocalizations.credit,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
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
                      Flexible(
                        child: Text(
                          appLocalizations.exchange,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
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
            SizedBox(
              child: car.vip ?? false
                  ? const Icon(
                      Icons.shield_sharp,
                      color: Colors.amberAccent,
                      size: 70,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
