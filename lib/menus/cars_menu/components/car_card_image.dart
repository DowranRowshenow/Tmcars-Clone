// THIS CUSTOM WIDGETS USAGE FREQUENCY IS {HIGH} AND {DYNAMIC}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/placeholder_image.dart';
import '../../../providers/traffic.dart';

class CarCardImage extends StatelessWidget {
  const CarCardImage({super.key, required this.img, this.width});

  final String? img;
  final double? width;
  static const double maxWidth = 90.0;
  static const double height = 90.0;

  @override
  Widget build(BuildContext context) {
    if (context.read<TrafficManager>().isStandart() && img != null) {
      return CachedNetworkImage(
        imageUrl: img!,
        width: maxWidth,
        height: height,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.none,
        memCacheHeight: height.toInt(),
        memCacheWidth: maxWidth.toInt(),
        placeholder: (BuildContext context, String url) =>
            buildImagePlaceholder(context, height: height, width: maxWidth),
        errorWidget: (BuildContext context, String url, Object error) =>
            buildImagePlaceholder(context, height: height, width: maxWidth),
      );
    }
    return buildImagePlaceholder(context, height: height, width: maxWidth);
  }
}
