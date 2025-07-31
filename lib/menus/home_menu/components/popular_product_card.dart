import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/placeholder_image.dart';
import '../../../models/popular_product_model.dart';
import '../../../providers/locale.dart';
import '../../../providers/themes.dart';
import '../../../providers/traffic.dart';

class PopularProductCard extends StatelessWidget {
  const PopularProductCard({super.key, required this.product});
  final PopularProduct product;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final Locale locale = context.watch<LocaleManager>().locale;
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
            context.watch<TrafficManager>().isStandart()
                ? CachedNetworkImage(
                    imageUrl: product.img,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.low,
                    height: height,
                    width: width,
                    memCacheWidth: width.toInt(),
                    placeholder: (context, url) => buildImagePlaceholder(
                      context,
                      height: height,
                      width: width,
                    ),
                    errorWidget: (context, url, error) => buildImagePlaceholder(
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
                children: [
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
                    locale.languageCode == "ru"
                        ? product.descriptionRu
                        : product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    locale.languageCode == 'ru'
                        ? product.timeLocationRu
                        : product.timeLocation,
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
