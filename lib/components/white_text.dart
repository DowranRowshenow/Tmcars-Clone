import 'package:flutter/material.dart';

class WhiteText extends StatelessWidget {
  const WhiteText(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(color: Colors.white));
  }
}
