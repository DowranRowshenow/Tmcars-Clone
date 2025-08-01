import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/dot_tab.dart';
import '../../components/download_button.dart';
import '../../components/placeholder_image.dart';
import '../../utils/constants.dart';
import '../../utils/download_controller.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({super.key, required this.imageUrls});
  final List<String> imageUrls;

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // New: ValueNotifier to hold the current tab index, which ValueListenableBuilder can listen to
  late ValueNotifier<int> _currentTabIndexNotifier;

  // Map to store rotation state for each image, keyed by index
  final ValueNotifier<Map<int, int>> _imageQuarterTurns =
      ValueNotifier<Map<int, int>>({});

  // --- Maps to manage download state for each image ---
  final Map<int, DownloadController> _downloadControllers = {};

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    _tabController = TabController(
      length: widget.imageUrls.length,
      vsync: this,
    );
    for (int i = 0; i < _tabController.length; i++) {
      _downloadControllers[i] = DownloadController();
    }

    // Initialize _currentTabIndexNotifier and add listener to _tabController
    _currentTabIndexNotifier = ValueNotifier<int>(_tabController.index);
    _tabController.addListener(() {
      if (_currentTabIndexNotifier.value != _tabController.index) {
        _currentTabIndexNotifier.value = _tabController.index;
      }
    });

    for (int i = 0; i < widget.imageUrls.length; i++) {
      _imageQuarterTurns.value[i] = 0; // Initialize rotation for each image
    }
    // Trigger a rebuild for _imageQuarterTurns to reflect initial values
    _imageQuarterTurns.value = Map.from(_imageQuarterTurns.value);
  }

  @override
  void dispose() {
    // Dispose all individual ValueNotifiers for download state using for-in loop
    for (int i = 0; i < _tabController.length; i++) {
      _downloadControllers[i]!.dispose();
    }
    _tabController.dispose();
    _currentTabIndexNotifier.dispose(); // Dispose the new notifier
    _imageQuarterTurns.dispose(); // Dispose rotation notifier

    super.dispose();
  }

  void _rotateCurrentImage() {
    final int currentIndex = _tabController.index;
    int currentTurns = _imageQuarterTurns.value[currentIndex] ?? 0;
    final int newTurns = (currentTurns - 1 + 4) % 4;
    _imageQuarterTurns.value = {
      ..._imageQuarterTurns.value,
      currentIndex: newTurns,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: Constants.splashRadius,
          splashColor: Colors.transparent,
        ),
        actions: <Widget>[
          IconButton(
            splashColor: Colors.transparent,
            splashRadius: Constants.splashRadius,
            icon: const Icon(Icons.rotate_left_outlined),
            onPressed: _rotateCurrentImage,
          ),
          ValueListenableBuilder<int>(
            valueListenable: _currentTabIndexNotifier,
            builder: (context, currentIndex, child) {
              return DownloadButton(
                url: widget.imageUrls[currentIndex],
                downloadController: _downloadControllers[currentIndex]!,
              );
            },
          ),
          // ------------------------------------
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 1.0,
              maxScale: 5.0,
              child: ValueListenableBuilder<Map<int, int>>(
                valueListenable: _imageQuarterTurns,
                builder: (context, imageQuarterTurnsValue, child) {
                  return TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      for (int i = 0; i < widget.imageUrls.length; i++)
                        RotatedBox(
                          quarterTurns: imageQuarterTurnsValue[i] ?? 0,
                          child: CachedNetworkImage(
                            imageUrl: widget.imageUrls[i],
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                buildImagePlaceholder(context),
                            fadeInDuration: const Duration(milliseconds: 200),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 20,
            child: SafeArea(
              child: DotTab(
                length: widget.imageUrls.length,
                controller: _tabController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
