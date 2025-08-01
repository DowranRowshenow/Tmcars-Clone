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
  final ValueNotifier<int> _currentTabIndexNotifier = ValueNotifier<int>(0);
  late int length;
  final double width = 400.0;

  @override
  void initState() {
    super.initState();
    length = widget.mainVideo == null
        ? widget.imageUrls.length
        : widget.imageUrls.length + 1;
    controller = TabController(length: length, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    _currentTabIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapImage as GestureTapCallback,
      child: Stack(
        children: <Widget>[
          TabBarView(
            controller: controller,
            children: <Widget>[
              if (widget.mainVideo != null)
                GestureDetector(
                  onTap: widget.onTapVideo as GestureTapCallback,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: CachedNetworkImage(
                          imageUrl: widget.mainVideo!.thumbnail,
                          fit: BoxFit.cover,
                          memCacheWidth: width.toInt(),
                          filterQuality: FilterQuality.low,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              buildImagePlaceholder(context),
                        ),
                      ),
                      const Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.circle,
                          color: Colors.black,
                          size: 40.0,
                        ),
                      ),
                      const Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.play_circle_fill,
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
                ),
              for (int i = 0; i < widget.imageUrls.length; i++)
                CachedNetworkImage(
                  imageUrl: widget.imageUrls[i],
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                  memCacheWidth: width.toInt(),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      buildImagePlaceholder(context),
                ),
            ],
          ),
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
}
