import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../components/ripple_container.dart';
import '../../../helper/size_config.dart';
import '../../../helper/themes.dart';
import '../../../models/PopularProduct.dart';

class PopularProductCard extends StatelessWidget {
  const PopularProductCard({Key? key, required this.product}) : super(key: key);
  final PopularProduct product;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return RippleContainer(
      padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
      onTap: () {},
      color: Colors.transparent,
      border: const Border(
        bottom: BorderSide(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
              imageUrl: product.img,
              height: getProportionateScreenHeight(90),
              width: getProportionateScreenWidth(90),
              fit: BoxFit.fitHeight,
              placeholder: (context, url) => Center(
                    child: Image.memory(kTransparentImage),
                    /*child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),*/
                  ),
              errorWidget: (context, url, error) {
                if (kDebugMode) {
                  print('Error loading image: $url, error: $error');
                }
                return Container(
                  width: getProportionateScreenWidth(90),
                  height: getProportionateScreenHeight(90),
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: getProportionateScreenWidth(40),
                      color: Colors.grey[600],
                    ),
                  ),
                );
              }),
          SizedBox(width: getProportionateScreenWidth(10)),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  product.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 12,
                    color: appColors.textHintThemeColor,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  product.timeLocation,
                  softWrap: true,
                  textWidthBasis: TextWidthBasis.parent,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontSize: 14,
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
