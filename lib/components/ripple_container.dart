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
        mainAxisSize: MainAxisSize
            .min, // Makes the Column only take necessary vertical space
        children: [
          Material(
            // The color property sets the background color of the Material surface.
            // This is also the surface over which the InkWell's ripple will draw.
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            clipBehavior: Clip
                .antiAlias, // Ensures the Material's content is clipped if rounded
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: onTap,
              splashColor: splashColor,
              highlightColor: highlightColor,
              child: Container(
                padding: padding,
                width:
                    width, // Apply width if provided (can be null for auto-sizing)
                height:
                    height, // Apply height if provided (can be null for auto-sizing)
                decoration: BoxDecoration(
                  // The color here is transparent to allow the Material's color (and ripple) to show through
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: border, // Apply border directly if it's not null
                ),
                alignment: Alignment.center,
                child: child,
              ),
            ),
          ),
          // Conditionally add Padding and Text only if 'text' is provided
          if (text != null) ...[
            // Using spread operator for concise conditional widgets
            const Padding(
              padding: EdgeInsets.all(5),
            ), // Use const for performance
            Text(
              text!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ), // Use const for performance
            ),
          ],
        ],
      ),
    );
  }
}
