import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmcarsclone/components/dot_tab.dart';
import 'package:tmcarsclone/components/placeholder_image.dart';

class AppBarImage extends StatefulWidget {
  const AppBarImage({super.key, required this.imageUrls});
  final List<String> imageUrls;

  @override
  // ignore: library_private_types_in_public_api
  _AppBarImageState createState() => _AppBarImageState();
}

class _AppBarImageState extends State<AppBarImage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  final ValueNotifier<int> _currentTabIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    controller = TabController(length: widget.imageUrls.length, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    _currentTabIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        TabBarView(
          controller: controller,
          children: <Widget>[
            for (int i = 0; i < widget.imageUrls.length; i++)
              CachedNetworkImage(
                imageUrl: widget.imageUrls[i],
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    buildImagePlaceholder(context),
                imageBuilder: (context, imageProvider) {
                  return Image(
                    image: imageProvider,
                    fit: BoxFit.cover, // Apply the fit here too
                  );
                },
              ),
          ],
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 20,
          child: DotTab(
            length: widget.imageUrls.length,
            controller: controller,
          ),
        ),
      ],
    );
  }
}
