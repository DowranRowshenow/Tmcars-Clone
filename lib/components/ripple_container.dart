import 'package:flutter/material.dart';

class RippleContainer extends StatelessWidget {
  const RippleContainer({
    Key? key,
    required this.onTap,
    required this.child,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.width = 150,
    this.height = 217,
    this.text,
    this.color = Colors.blue,
    this.borderRadius = 0,
    this.border = const Border(),
  }) : super(key: key);

  final double height;
  final double width;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color color;
  final VoidCallback onTap;
  final Widget child;
  final String? text;
  final double borderRadius;
  final Border border;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        children: [
          Material(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: onTap,
              child: Container(
                  padding: padding,
                  //width: width,
                  //height: height,
                  decoration: border == const Border()
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          color: Colors.transparent,
                        )
                      : BoxDecoration(
                          color: Colors.transparent,
                          border: border,
                        ),
                  alignment: Alignment.center,
                  child: child),
            ),
          ),
          text != null
              ? const Padding(padding: EdgeInsets.all(5))
              : Container(),
          text != null
              ? Text(
                  text!,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                )
              : Container(),
        ],
      ),
    );
  }
}
