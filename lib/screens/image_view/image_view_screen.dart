import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({super.key, required this.imageUrls});
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Container());
  }
}
