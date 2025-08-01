import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../components/dot_tab.dart';
import '../components/placeholder_image.dart';
import '../models/article_detail_model.dart';

class AppBarImage extends StatefulWidget {
  const AppBarImage({
    super.key,
    required this.imageUrls,
    this.mainVideo,
    this.onTapVideo,
    this.onTapImage,
  });
  final List<String> imageUrls;
  final MainVideo? mainVideo;
  final Function? onTapVideo;
  final Function? onTapImage;

  @override
  // ignore: library_private_types_in_public_api
  _AppBarImageState createState() => _AppBarImageState();
}

class _AppBarImageState extends State<AppBarImage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  late int length;
  final double width = 400.0;

  // Cache the total length to avoid recalculation
  int get totalLength => widget.mainVideo == null
      ? widget.imageUrls.length
      : widget.imageUrls.length + 1;

  @override
  void initState() {
    super.initState();
    length = totalLength;
    controller = TabController(length: length, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapImage as GestureTapCallback,
      child: Stack(
        children: <Widget>[
          // Optimized TabBarView with better image handling
          TabBarView(
            controller: controller,
            children: <Widget>[
              if (widget.mainVideo != null) _buildVideoThumbnail(),
              ...widget.imageUrls.map((String url) => _buildImage(url)),
            ],
          ),
          // Dot indicators
          Positioned(
            right: 0,
            left: 0,
            bottom: 20,
            child: DotTab(length: length, controller: controller),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoThumbnail() {
    return GestureDetector(
      onTap: widget.onTapVideo as GestureTapCallback,
      child: Stack(
        children: <Widget>[
          // Video thumbnail - ensure it fills the entire space
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: widget.mainVideo!.thumbnail,
              fit: BoxFit.cover,
              memCacheWidth: width.toInt(),
              filterQuality: FilterQuality.low,
              placeholder: (BuildContext context, String url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (BuildContext context, String url, Object error) =>
                  buildImagePlaceholder(context),
            ),
          ),
          // Play button overlay
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.low,
      memCacheWidth: width.toInt(),
      placeholder: (BuildContext context, String url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (BuildContext context, String url, Object error) =>
          buildImagePlaceholder(context),
    );
  }
}
