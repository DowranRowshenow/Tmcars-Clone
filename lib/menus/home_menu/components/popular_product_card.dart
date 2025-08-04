import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/placeholder_image.dart';
import '../../../models/app_settings_model.dart';
import '../../../providers/locale.dart';
import '../../../providers/themes.dart';
import '../../../providers/traffic.dart';

class PopularProductCard extends StatelessWidget {
  const PopularProductCard({super.key, required this.product});
  final DashFeaturedItem product;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final Locale locale = context.read<LocaleManager>().locale;
    const double width = 95.0;
    const double height = 85.0;

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
        onTap: () {},
        titleAlignment: ListTileTitleAlignment.center,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            context.read<TrafficManager>().isStandart()
                ? CachedNetworkImage(
                    imageUrl: product.img,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.low,
                    height: height,
                    width: width,
                    memCacheWidth: width.toInt(),
                    placeholder: (BuildContext context, String url) =>
                        buildImagePlaceholder(
                          context,
                          height: height,
                          width: width,
                        ),
                    errorWidget:
                        (BuildContext context, String url, Object error) =>
                            buildImagePlaceholder(
                              context,
                              height: height,
                              width: width,
                            ),
                  )
                : buildImagePlaceholder(context, height: height, width: width),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.getDescription(locale.languageCode),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.getTimeLocation(locale.languageCode),
                    maxLines: 1,
                    textWidthBasis: TextWidthBasis.parent,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 12,
                      color: appColors.textHintThemeColor,
                      fontWeight: FontWeight.w400,
                    ),
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
