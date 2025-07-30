import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/placeholder_image.dart';
import '../../../providers/traffic.dart';

class ArticleCardImage extends StatelessWidget {
  const ArticleCardImage({
    super.key,
    required this.articleImg,
    required this.videoExist,
  });

  final String? articleImg;
  final bool? videoExist;
  final double height = 90.0;
  // final double width = 170.0;

  Widget _buildImageOrPlaceholder(BuildContext context) {
    final bool isStandardTraffic = context.watch<TrafficManager>().isStandart();
    final double width = MediaQuery.of(context).size.width * 0.4;

    if (isStandardTraffic && articleImg != null) {
      return CachedNetworkImage(
        imageUrl: articleImg!,
        width: width,
        height: height,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.low,
        memCacheWidth: width.toInt(),
        placeholder: (context, url) =>
            buildImagePlaceholder(context, height: height, width: width),
        errorWidget: (context, url, error) =>
            buildImagePlaceholder(context, height: height, width: width),
      );
    } else {
      return buildImagePlaceholder(context, height: height, width: width);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (videoExist == true) {
      return Stack(
        children: <Widget>[
          _buildImageOrPlaceholder(context),
          const Positioned(
            top: 10,
            right: 10,
            child: Icon(Icons.circle, color: Colors.black, size: 30.0),
          ),
          const Positioned(
            top: 10,
            right: 10,
            child: Icon(
              Icons.play_circle_fill,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ],
      );
    } else {
      return _buildImageOrPlaceholder(context);
    }
  }
}
