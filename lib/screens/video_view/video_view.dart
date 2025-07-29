import 'package:flutter/material.dart';

import '../../components/back_icon_button.dart';
import '../../utils/constants.dart';
import '../../utils/downloader.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen>
    with SingleTickerProviderStateMixin {
  int _videoQuarterTurn = 0;

  void _rotateCurrentVideo() {
    if (mounted) {
      setState(() {
        int currentTurns = _videoQuarterTurn;
        currentTurns = (currentTurns - 1) % 4;
        if (currentTurns < 0) {
          currentTurns += 4;
        }
        _videoQuarterTurn = currentTurns;
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
              child: RotatedBox(
                quarterTurns: _videoQuarterTurn,
                child: Container(), // TODO: player
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
                    onPressed: _rotateCurrentVideo,
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    splashRadius: Constants.splashRadius,
                    icon: const Icon(Icons.download_outlined),
                    onPressed: () => downloadImage(widget.videoUrl),
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
