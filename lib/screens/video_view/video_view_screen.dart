import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../components/back_icon_button.dart';
import '../../components/download_button.dart';
import '../../models/article_detail_model.dart';
import '../../utils/constants.dart';
import '../../utils/download_controller.dart';

class VideoViewScreen extends StatefulWidget {
  const VideoViewScreen({super.key, required this.video});
  final MainVideo video;

  @override
  State<VideoViewScreen> createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  late VideoPlayerController videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  late final DownloadController _downloadController;
  final List<DeviceOrientation> _orientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
  ];
  int _currentOrientationIndex = 0;

  // Bottom slider visibility state
  bool _showBottomSlider = false;

  @override
  void initState() {
    super.initState();
    _downloadController = DownloadController();
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.url),
    );
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      videoPlayerController.play();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _downloadController.dispose();
    videoPlayerController.dispose();
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

  void _toggleBottomSlider() {
    setState(() {
      _showBottomSlider = !_showBottomSlider;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: buildBackIconButton(context),
        actions: <Widget>[
          IconButton(
            splashColor: Colors.transparent,
            splashRadius: Constants.splashRadius,
            icon: const Icon(Icons.screen_rotation, color: Colors.white),
            onPressed: _rotateScreen,
          ),
          DownloadButton(
            url: widget.video.url,
            downloadController: _downloadController,
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GestureDetector(
                  onTap: _toggleBottomSlider,
                  child: Center(
                    child: InteractiveViewer(
                      panEnabled: true,
                      minScale: 0.5,
                      maxScale: 5.0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: SizedBox(
                            width: videoPlayerController.value.size.width,
                            height: videoPlayerController.value.size.height,
                            child: VideoPlayer(videoPlayerController),
                          ),
                        ),
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
                    const Center(child: CircularProgressIndicator()),
                  ],
                );
              }
            },
          ),
          Center(
            child: ValueListenableBuilder<VideoPlayerValue>(
              valueListenable: videoPlayerController,
              builder: (context, value, child) {
                return value.isBuffering
                    ? const CircularProgressIndicator()
                    : const SizedBox();
              },
            ),
          ),
          // Bottom video controls
          if (_showBottomSlider)
            Center(
              child: GestureDetector(
                onTap: _togglePlayPause,
                child: ValueListenableBuilder<VideoPlayerValue>(
                  valueListenable: videoPlayerController,
                  builder: (context, value, child) {
                    return Icon(
                      value.isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: Colors.white,
                      size: 50,
                    );
                  },
                ),
              ),
            ),
          if (_showBottomSlider)
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      // Current time
                      ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: videoPlayerController,
                        builder: (context, value, child) {
                          return Text(
                            _formatDuration(value.position),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 10),

                      // Progress slider
                      Expanded(
                        child: ValueListenableBuilder<VideoPlayerValue>(
                          valueListenable: videoPlayerController,
                          builder: (context, value, child) {
                            return SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Colors.white.withValues(
                                  alpha: 0.3,
                                ),
                                thumbColor: Colors.white,
                                overlayColor: Colors.white.withValues(
                                  alpha: 0.2,
                                ),
                                trackHeight: 2,
                              ),
                              child: Slider(
                                value: value.duration.inMilliseconds > 0
                                    ? value.position.inMilliseconds /
                                          value.duration.inMilliseconds
                                    : 0.0,
                                onChanged: (newValue) {
                                  final duration = value.duration;
                                  final position = Duration(
                                    milliseconds:
                                        (newValue * duration.inMilliseconds)
                                            .round(),
                                  );
                                  videoPlayerController.seekTo(position);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Total duration
                      ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: videoPlayerController,
                        builder: (context, value, child) {
                          return Text(
                            _formatDuration(value.duration),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
