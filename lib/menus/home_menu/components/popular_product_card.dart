import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../../components/placeholder_image.dart';
import '../../../components/ripple_container.dart';
import '../../../providers/locale.dart';
import '../../../providers/themes.dart';
import '../../../models/popular_product_model.dart';
import '../../../utils/constants.dart';

class PopularProductCard extends StatelessWidget {
  const PopularProductCard({super.key, required this.product});
  final PopularProduct product;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return RippleContainer(
      padding: EdgeInsets.all(8.0),
      onTap: () {},
      color: Colors.transparent,
      border: Border(
        bottom: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: product.img,
            height: Constants.placeHolderSize,
            width: Constants.placeHolderSize,
            fit: BoxFit.fitHeight,
            placeholder: (context, url) => buildImagePlaceholder(context),
            errorWidget: (context, url, error) =>
                buildImagePlaceholder(context),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3),
                Text(
                  context.watch<LocaleManager>().locale.languageCode == 'ru'
                      ? product.descriptionRu
                      : product.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 12,
                    color: appColors.textHintThemeColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  context.watch<LocaleManager>().locale.languageCode == 'ru'
                      ? product.timeLocationRu
                      : product.timeLocation,
                  maxLines: 1,
                  softWrap: true,
                  textWidthBasis: TextWidthBasis.parent,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
