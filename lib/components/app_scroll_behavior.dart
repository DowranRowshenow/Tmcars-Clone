import 'package:flutter/material.dart';

/// A scroll behavior that enables the "stretch" overscroll effect.
///
/// This is the default behavior on Android 12+ and provides a modern,
/// fluid feel when overscrolling content.
class AppScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return StretchingOverscrollIndicator(
      axisDirection: details.direction,
      child: child,
    );
  }
}
