import 'package:flutter/material.dart';

import 'ripple_container.dart';
import '../models/product_model.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

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
            widget.product.images[0].url,
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
                Text(widget.product.name, style: const TextStyle(fontSize: 16)),
                SizedBox(height: 5),
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
                SizedBox(height: 5),
                Text("${widget.product.price} TMT"),
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
