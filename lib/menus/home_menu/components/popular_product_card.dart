import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../../components/ripple_container.dart';
import '../../../providers/locale.dart';
import '../../../providers/themes.dart';
import '../../../models/popular_product_model.dart';

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
      border: const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: product.img,
            height: 90,
            width: 90,
            fit: BoxFit.fitHeight,
            placeholder: (context, url) {
              return Container(
                width: 90,
                height: 90,
                color: appColors.tileThemeColor,
                child: Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 50,
                    color: Colors.grey[700]!,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                width: 90,
                height: 90,
                color: appColors.tileThemeColor,
                child: Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 50,
                    color: Colors.grey[700]!,
                  ),
                ),
              );
            },
          ),
          SizedBox(width: 10),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3),
                Text(
                  context.watch<LocaleManager>().locale == Locale('ru')
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
                  context.watch<LocaleManager>().locale == Locale('ru')
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
