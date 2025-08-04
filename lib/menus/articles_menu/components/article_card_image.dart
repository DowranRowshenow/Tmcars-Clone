// THIS CUSTOM WIDGETS USAGE FREQUENCY IS {HIGH} AND {DYNAMIC}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/placeholder_image.dart';
import '../../../providers/traffic.dart';

class ArticleCardImage extends StatelessWidget {
  const ArticleCardImage({
    super.key,
    required this.articleImg,
    this.videoExist = false,
    this.width,
  });

  final String? articleImg;
  final bool? videoExist;
  final double? width;
  static const double maxWidth = 260.0;
  static const double height = 90.0;

  Widget _buildImage(BuildContext context) {
    if (context.read<TrafficManager>().isStandart() && articleImg != null) {
      return CachedNetworkImage(
        imageUrl: articleImg!,
        width: width,
        height: height,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.none,
        memCacheHeight: height.toInt(),
        memCacheWidth:
            (width ??
                    (MediaQuery.of(context).size.width * 0.4).clamp(
                      height,
                      maxWidth,
                    ))
                .toInt(),
        placeholder: (BuildContext context, String url) =>
            buildImagePlaceholder(context, height: height, width: width),
        errorWidget: (BuildContext context, String url, Object error) =>
            buildImagePlaceholder(context, height: height, width: width),
      );
    }
    return buildImagePlaceholder(context, height: height, width: width);
  }

  @override
  Widget build(BuildContext context) {
    if (videoExist == true) {
      return Stack(
        children: <Widget>[
          _buildImage(context),
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
    }
    return _buildImage(context);
  }
}
