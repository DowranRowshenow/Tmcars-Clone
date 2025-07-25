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
  final double size = 96;

  Widget _buildImagePlaceholder(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    return Container(
      width: size,
      height: size,
      color: appColors.tileThemeColor,
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          size: 50,
          color: Colors.grey[700]!,
        ),
      ),
    );
  }

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
            height: size,
            width: size,
            fit: BoxFit.fitHeight,
            placeholder: (context, url) => _buildImagePlaceholder(context),
            errorWidget: (context, url, error) =>
                _buildImagePlaceholder(context),
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
