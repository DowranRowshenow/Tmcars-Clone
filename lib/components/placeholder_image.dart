import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  const PlaceholderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      color: Colors.grey[300],
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          size: 40,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
