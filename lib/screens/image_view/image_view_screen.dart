import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/back_icon_button.dart';
import '../../components/dot_tab.dart';
import '../../components/placeholder_image.dart';
import '../../providers/traffic.dart';
import '../../utils/constants.dart';
import '../../utils/downloader.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({super.key, required this.imageUrls});
  final List<String> imageUrls;

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<int, int> _imageQuarterTurns = {};
  final Map<String, ui.Image> _loadedImages = {};
  final ValueNotifier<int> _currentTabIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.imageUrls.length,
      vsync: this,
    );

    // Initialize all image rotations to 0 quarter turns
    for (int i = 0; i < widget.imageUrls.length; i++) {
      _imageQuarterTurns[i] = 0;
    }

    // Add listener to load image dimensions when tab changes
    _tabController.addListener(_onTabChanged);

    // Load dimensions for the initial image
    if (widget.imageUrls.isNotEmpty) {
      _loadImageDimensions(widget.imageUrls[0]);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _currentTabIndexNotifier.dispose(); // <--- Dispose the notifier
    _loadedImages.forEach((key, image) => image.dispose());
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      _loadImageDimensions(widget.imageUrls[_tabController.index]);
    }
  }

  // New method to load and store image dimensions
  void _loadImageDimensions(String imageUrl) {
    // Only load if not already loaded
    if (_loadedImages.containsKey(imageUrl)) {
      return;
    }

    final ImageProvider imageProvider = CachedNetworkImageProvider(imageUrl);
    final ImageStream stream = imageProvider.resolve(ImageConfiguration.empty);

    ImageStreamListener? listener; // Declare listener here

    listener = ImageStreamListener(
      (ImageInfo info, bool synchronousCall) {
        if (mounted) {
          setState(() {
            _loadedImages[imageUrl] = info.image;
          });
        }
        // Remove listener after image is loaded to prevent multiple calls
        if (listener != null) {
          stream.removeListener(listener);
        }
      },
      onError: (Object exception, StackTrace? stackTrace) {
        debugPrint('Error loading image dimensions for $imageUrl: $exception');
        // Handle error, e.g., show a placeholder or error message
        if (listener != null) {
          stream.removeListener(listener);
        }
      },
    );

    stream.addListener(listener);
  }

  void _rotateCurrentImage() {
    if (mounted) {
      setState(() {
        final int currentIndex = _tabController.index;
        int currentTurns = _imageQuarterTurns[currentIndex] ?? 0;
        currentTurns = (currentTurns - 1) % 4;
        if (currentTurns < 0) {
          currentTurns += 4;
        }
        _imageQuarterTurns[currentIndex] = currentTurns;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: <Widget>[
          Center(
            child: InteractiveViewer(
              panEnabled: true, // Enable panning
              minScale: 0.5, // Minimum zoom scale
              maxScale: 4.0, // Maximum zoom scale
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  for (int i = 0; i < widget.imageUrls.length; i++)
                    Builder(
                      builder: (BuildContext innerContext) {
                        final int currentQuarterTurns =
                            _imageQuarterTurns[i] ?? 0;

                        return RotatedBox(
                          quarterTurns: currentQuarterTurns,
                          child: context.watch<TrafficManager>().isStandart()
                              ? CachedNetworkImage(
                                  imageUrl: widget.imageUrls[i],
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      buildImagePlaceholder(context),
                                  fadeInDuration: const Duration(
                                    milliseconds: 200,
                                  ),
                                  memCacheHeight: 400,
                                  memCacheWidth: 600,
                                )
                              : buildImagePlaceholder(context),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: buildBackIconButton(context),
                actions: <Widget>[
                  IconButton(
                    splashColor: Colors.transparent,
                    splashRadius: Constants.splashRadius,
                    icon: const Icon(Icons.rotate_left_outlined),
                    onPressed: _rotateCurrentImage,
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    splashRadius: Constants.splashRadius,
                    icon: const Icon(Icons.download_outlined),
                    onPressed: () =>
                        downloadImage(widget.imageUrls[_tabController.index]),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 20,
            child: DotTab(
              length: widget.imageUrls.length,
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}
