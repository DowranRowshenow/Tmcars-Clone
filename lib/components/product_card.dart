import 'package:flutter/material.dart';

import '../models/popular_product_model.dart';
import '../helper/constants.dart' as constants;
import 'ripple_container.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});
  final PopularProduct product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return RippleContainer(
      padding: EdgeInsets.all(5),
      onTap: () {},
      color: Colors.transparent,
      border: const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      child: Row(
        children: [
          Image.network(
            widget.product.img,
            height: 90,
            width: 90,
            fit: BoxFit.fitHeight,
          ),
          SizedBox(width: 10),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  style: const TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                Text(
                  constants.locale == Locale('ru')
                      ? widget.product.timeLocationRu
                      : widget.product.timeLocation,
                  softWrap: true,
                  textWidthBasis: TextWidthBasis.parent,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 5),
                Text("${widget.product.p} TMT"),
                SizedBox(height: 5),
                Text(
                  widget.product.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
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
