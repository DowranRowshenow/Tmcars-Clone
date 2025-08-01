import 'package:flutter/material.dart';

class RippleContainer extends StatelessWidget {
  const RippleContainer({
    super.key,
    required this.onTap,
    required this.child,
    this.margin = EdgeInsets.zero, // Use EdgeInsets.zero for no margin
    this.padding = EdgeInsets.zero, // Use EdgeInsets.zero for no padding
    this.width, // Make nullable for content-based width or external constraints
    this.height, // Make nullable for content-based height or external constraints
    this.text,
    this.color = Colors.blue, // Default background color for the Material
    this.borderRadius =
        0.0, // Use double literal, default to no rounded corners
    this.border, // Make nullable to apply border only when provided
    this.splashColor, // Optional: customize ripple color
    this.highlightColor, // Optional: customize highlight color
  });

  final double? height; // Now nullable: height will be content-driven if null
  final double? width; // Now nullable: width will be content-driven if null
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color color;
  final VoidCallback onTap;
  final Widget child;
  final String? text;
  final double borderRadius;
  final Border? border; // Border is now optional
  final Color? splashColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Material(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: onTap,
              splashColor: splashColor,
              highlightColor: highlightColor,
              child: Container(
                padding: padding,
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: border,
                ),
                alignment: Alignment.center,
                child: child,
              ),
            ),
          ),
          if (text != null) ...<Widget>[
            const Padding(padding: EdgeInsets.all(5)),
            Text(
              text!,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }
}
