// THIS CUSTOM WIDGETS USAGE FREQUENCY IS {HIGH} AND {DYNAMIC}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../components/placeholder_image.dart';

class ArticleCardImage extends StatelessWidget {
  const ArticleCardImage({
    super.key,
    required this.articleImg,
    required this.videoExist,
    this.height = 90.0,
    required this.width,
    required this.isStandardTraffic,
  });

  final String? articleImg;
  final bool? videoExist;
  final double height;
  final double width;
  final bool isStandardTraffic;

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: articleImg!,
      width: width,
      height: height,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.none,
      memCacheHeight: height.toInt(),
      memCacheWidth: width.toInt(),
      placeholder: (BuildContext context, String url) =>
          buildImagePlaceholder(context, height: height, width: width),
      errorWidget: (BuildContext context, String url, Object error) =>
          buildImagePlaceholder(context, height: height, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (videoExist == true) {
      return Stack(
        children: <Widget>[
          isStandardTraffic && articleImg != null
              ? _buildImage(context)
              : buildImagePlaceholder(context, height: height, width: width),
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
      return _buildImage(context);
    }
  }
}
