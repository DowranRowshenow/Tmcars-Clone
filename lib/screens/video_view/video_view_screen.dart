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
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  late final DownloadController _downloadController = DownloadController();
  final List<DeviceOrientation> _orientations = <DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
  ];
  int _currentOrientationIndex = 0;
  final ValueNotifier<bool> _showBottomSlider = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isMuted = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.url),
    );
    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((
      _,
    ) {
      _videoPlayerController.play();
      SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.portraitUp,
      ]);
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
    _downloadController.dispose();
    _showBottomSlider.dispose();
    _isMuted.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _rotateScreen() {
    if (mounted) {
      setState(() {
        _currentOrientationIndex =
            (_currentOrientationIndex + 1) % _orientations.length;
        SystemChrome.setPreferredOrientations(<DeviceOrientation>[
          _orientations[_currentOrientationIndex],
        ]);
      });
    }
  }

  void _togglePlayPause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
  }

  void _toggleBottomSlider() {
    _showBottomSlider.value = !_showBottomSlider.value;
  }

  void _toggleVolume() {
    _isMuted.value = !_isMuted.value;
    if (_isMuted.value) {
      _videoPlayerController.setVolume(0.0);
    } else {
      _videoPlayerController.setVolume(1.0);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String minutes = twoDigits(duration.inMinutes.remainder(60));
    final String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          FutureBuilder<void>(
            future: _initializeVideoPlayerFuture,
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: InteractiveViewer(
                    panEnabled: false,
                    minScale: 0.5,
                    maxScale: 5.0,
                    child: GestureDetector(
                      onTap: _toggleBottomSlider,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: SizedBox(
                            width: _videoPlayerController.value.size.width,
                            height: _videoPlayerController.value.size.height,
                            child: VideoPlayer(_videoPlayerController),
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
                      child: GestureDetector(
                        onTap: _toggleBottomSlider,
                        child: CachedNetworkImage(
                          imageUrl: widget.video.thumbnail,
                          fit: BoxFit.fitWidth,
                          filterQuality: FilterQuality.low,
                        ),
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
              valueListenable: _videoPlayerController,
              builder:
                  (
                    BuildContext context,
                    VideoPlayerValue value,
                    Widget? child,
                  ) {
                    return value.isBuffering
                        ? const CircularProgressIndicator()
                        : const SizedBox();
                  },
            ),
          ),
          // Bottom video controls
          // Animated play/pause button
          Center(
            child: ValueListenableBuilder<bool>(
              valueListenable: _showBottomSlider,
              builder: (BuildContext context, bool showSlider, Widget? child) {
                return AnimatedOpacity(
                  opacity: showSlider ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: GestureDetector(
                    onTap: _togglePlayPause,
                    child: ValueListenableBuilder<VideoPlayerValue>(
                      valueListenable: _videoPlayerController,
                      builder:
                          (
                            BuildContext context,
                            VideoPlayerValue value,
                            Widget? child,
                          ) {
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
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<bool>(
              valueListenable: _showBottomSlider,
              builder: (BuildContext context, bool showSlider, Widget? child) {
                return AnimatedContainer(
                  height: 80,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  transform: Matrix4.translationValues(
                    0,
                    showSlider ? 0 : -100, // Move up to hide off screen
                    0,
                  ),
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: buildBackIconButton(context),
                    actions: <Widget>[
                      ValueListenableBuilder<bool>(
                        valueListenable: _isMuted,
                        builder:
                            (
                              BuildContext context,
                              bool isMuted,
                              Widget? child,
                            ) {
                              return IconButton(
                                splashColor: Colors.transparent,
                                splashRadius: Constants.splashRadius,
                                icon: Icon(
                                  isMuted
                                      ? Icons.volume_off_outlined
                                      : Icons.volume_up_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: _toggleVolume,
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
                        downloadController: _downloadController,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Animated bottom video controls
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ValueListenableBuilder<bool>(
              valueListenable: _showBottomSlider,
              builder: (BuildContext context, bool showSlider, Widget? child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  transform: Matrix4.translationValues(
                    0,
                    showSlider ? 0 : 100, // Move up from bottom when shown
                    0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(
                          children: <Widget>[
                            // Current time
                            ValueListenableBuilder<VideoPlayerValue>(
                              valueListenable: _videoPlayerController,
                              builder:
                                  (
                                    BuildContext context,
                                    VideoPlayerValue value,
                                    Widget? child,
                                  ) {
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
                                valueListenable: _videoPlayerController,
                                builder:
                                    (
                                      BuildContext context,
                                      VideoPlayerValue value,
                                      Widget? child,
                                    ) {
                                      return SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: Colors.white,
                                          inactiveTrackColor: Colors.white
                                              .withValues(alpha: 0.3),
                                          thumbColor: Colors.white,
                                          overlayColor: Colors.white.withValues(
                                            alpha: 0.2,
                                          ),
                                          trackHeight: 2,
                                        ),
                                        child: Slider(
                                          value:
                                              value.duration.inMilliseconds > 0
                                              ? value.position.inMilliseconds /
                                                    value
                                                        .duration
                                                        .inMilliseconds
                                              : 0.0,
                                          onChanged: (double newValue) {
                                            final Duration duration =
                                                value.duration;
                                            final Duration position = Duration(
                                              milliseconds:
                                                  (newValue *
                                                          duration
                                                              .inMilliseconds)
                                                      .round(),
                                            );
                                            _videoPlayerController.seekTo(
                                              position,
                                            );
                                          },
                                        ),
                                      );
                                    },
                              ),
                            ),
                            const SizedBox(width: 10),

                            // Total duration
                            ValueListenableBuilder<VideoPlayerValue>(
                              valueListenable: _videoPlayerController,
                              builder:
                                  (
                                    BuildContext context,
                                    VideoPlayerValue value,
                                    Widget? child,
                                  ) {
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
