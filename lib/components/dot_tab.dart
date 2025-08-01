import 'package:flutter/material.dart';

class DotTab extends StatelessWidget {
  const DotTab({super.key, required this.length, required this.controller});
  final int length;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animation!,
      builder: (BuildContext context, Widget? child) {
        final double animationValue = controller.animation!.value;
        final int primaryIndex = animationValue.floor();
        final int secondaryIndex = (animationValue + 1).floor();
        final double progress = animationValue - primaryIndex;
        final double baseSize = 7;
        final double activeSize = 10;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < length; i++)
              Container(
                margin: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                width: Tween<double>(begin: baseSize, end: activeSize)
                    .transform(
                      i == primaryIndex
                          ? (1.0 - progress).clamp(0.0, 1.0)
                          : (i == secondaryIndex
                                ? progress.clamp(0.0, 1.0)
                                : 0.0),
                    ),
                height: Tween<double>(begin: baseSize, end: activeSize)
                    .transform(
                      i == primaryIndex
                          ? (1.0 - progress).clamp(0.0, 1.0)
                          : (i == secondaryIndex
                                ? progress.clamp(0.0, 1.0)
                                : 0.0),
                    ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.lerp(
                    Colors.grey, // Color when not active
                    Colors.white, // Color when active
                    i == primaryIndex
                        ? (1.0 - progress).clamp(0.0, 1.0)
                        : (i == secondaryIndex
                              ? progress.clamp(0.0, 1.0)
                              : 0.0),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
