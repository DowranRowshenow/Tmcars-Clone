import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../components/back_icon_button.dart';
import '../../components/download_button.dart';
import '../../models/article_detail_model.dart';
import '../../utils/constants.dart';
import '../../utils/downloader.dart';

class VideoViewScreen extends StatefulWidget {
  const VideoViewScreen({super.key, required this.video});
  final MainVideo video;

  @override
  State<VideoViewScreen> createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  late VideoPlayerController videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  final ValueNotifier<bool> _isDownloadComplete = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isDownloading = ValueNotifier<bool>(false);
  final ValueNotifier<double> _downloadProgress = ValueNotifier<double>(0.0);
  final ValueNotifier<bool> _isPlayingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<DownloadCancellationToken>
  _currentDownloadCancellationToken = ValueNotifier<DownloadCancellationToken>(
    DownloadCancellationToken(),
  );
  final List<DeviceOrientation> _orientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
  ];
  int _currentOrientationIndex = 0;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.url),
    );
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      videoPlayerController.play();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    });

    videoPlayerController.addListener(() {
      if (videoPlayerController.value.hasError) {}
      if (videoPlayerController.value.isInitialized &&
          !videoPlayerController.value.isPlaying &&
          videoPlayerController.value.duration ==
              videoPlayerController.value.position) {}
      if (_isPlayingNotifier.value != videoPlayerController.value.isPlaying) {
        _isPlayingNotifier.value = videoPlayerController.value.isPlaying;
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _currentDownloadCancellationToken.value.cancel();
    _currentDownloadCancellationToken.dispose();
    videoPlayerController.dispose();
    _isDownloadComplete.dispose();
    _isDownloading.dispose();
    _downloadProgress.dispose();
    _isPlayingNotifier.dispose();
    super.dispose();
  }

  void _rotateScreen() {
    if (mounted) {
      setState(() {
        _currentOrientationIndex =
            (_currentOrientationIndex + 1) % _orientations.length;
        SystemChrome.setPreferredOrientations([
          _orientations[_currentOrientationIndex],
        ]);
      });
    }
  }

  void _togglePlayPause() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GestureDetector(
                  onTap: _togglePlayPause,
                  child: Center(
                    child: InteractiveViewer(
                      panEnabled: true,
                      minScale: 0.5,
                      maxScale: 5.0,
                      child: AspectRatio(
                        aspectRatio: videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(videoPlayerController),
                      ),
                    ),
                  ),
                );
              } else {
                return Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: CachedNetworkImage(
                        imageUrl: widget.video.thumbnail,
                        fit: BoxFit.fitWidth,
                        filterQuality: FilterQuality.low,
                      ),
                    ),
                    const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ],
                );
              }
            },
          ),
          // AppBar for controls
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
                  ValueListenableBuilder<bool>(
                    valueListenable: _isPlayingNotifier,
                    builder: (context, isPlaying, child) {
                      return IconButton(
                        splashColor: Colors.transparent,
                        splashRadius: Constants.splashRadius,
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: _togglePlayPause,
                      );
                    },
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    splashRadius: Constants.splashRadius,
                    icon: const Icon(
                      Icons.screen_rotation,
                      color: Colors.white,
                    ),
                    onPressed: _rotateScreen,
                  ),
                  DownloadButton(
                    url: widget.video.url,
                    isDownloadingNotifier: _isDownloading,
                    downloadProgressNotifier: _downloadProgress,
                    cancellationTokenNotifier:
                        _currentDownloadCancellationToken,
                    isDownloadCompleteNotifier: _isDownloadComplete,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
