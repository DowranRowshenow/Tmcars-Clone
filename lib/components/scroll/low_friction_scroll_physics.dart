import 'package:flutter/material.dart' hide StretchingOverscrollIndicator;
// Make sure this path is correct for your stretch_scroll_indicator.dart file
import 'stretch_scroll_indicator.dart';

/// Custom ScrollPhysics for ultra-low friction scrolling that clamps at edges.
///
/// This provides a very smooth and long-gliding scroll experience that
/// stops precisely at the content boundaries without bounce or overscroll.
class LowFrictionScrollPhysics extends ScrollPhysics {
  const LowFrictionScrollPhysics({super.parent});

  @override
  LowFrictionScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return LowFrictionScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    // Corrected: Use toleranceFor(position) instead of this.tolerance
    final Tolerance currentTolerance = toleranceFor(position);

    if (velocity.abs() < currentTolerance.velocity) {
      return null;
    }
    if (velocity > 0.0 && position.pixels >= position.maxScrollExtent) {
      return null;
    }
    if (velocity < 0.0 && position.pixels <= position.minScrollExtent) {
      return null;
    }

    // This is the value to change for less friction in the main scroll.
    // A smaller value here will make the scroll glide longer.
    // Experiment with values like 0.0001, 0.00005, etc.
    const double customFriction = 0.002; // Adjusted for even more glide

    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      friction: customFriction,
      tolerance: currentTolerance,
    );
  }
}

/// A scroll behavior that enables the "stretch" overscroll effect
/// AND applies ultra-low friction scroll physics for the main scroll.
class AppScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // This re-enables the StretchingOverscrollIndicator as requested.
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
    return const LowFrictionScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
  }
}
