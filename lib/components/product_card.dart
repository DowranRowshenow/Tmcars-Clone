import 'package:flutter/material.dart';

import 'ripple_container.dart';
import '../helper/size_config.dart';
import '../models/Product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return RippleContainer(
      padding: EdgeInsets.all(getProportionateScreenHeight(5)),
      onTap: () {},
      color: Colors.transparent,
      border: const Border(
        bottom: BorderSide(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        children: [
          Image.network(
            widget.product.images[0].url,
            height: getProportionateScreenHeight(90),
            width: getProportionateScreenWidth(90),
            fit: BoxFit.fitHeight,
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(fontSize: 16),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  "${widget.product.location.name}, ${widget.product.updatedAt}",
                  softWrap: true,
                  textWidthBasis: TextWidthBasis.parent,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text("${widget.product.price} TMT"),
                SizedBox(height: getProportionateScreenHeight(5)),
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
