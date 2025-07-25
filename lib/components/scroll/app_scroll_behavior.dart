import 'package:flutter/material.dart' hide StretchingOverscrollIndicator;
import 'low_friction_scroll_physics.dart';
import 'stretch_scroll_indicator.dart';

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

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // This applies the ultra-low friction scroll physics to the main scroll.
    // AlwaysScrollableScrollPhysics ensures that scrolling is always possible,
    // even if the content does not overflow the viewport.
    return const UltraLowFrictionScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
  }
}
