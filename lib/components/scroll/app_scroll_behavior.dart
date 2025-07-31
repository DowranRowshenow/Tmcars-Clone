import 'package:flutter/material.dart' hide StretchingOverscrollIndicator;

import 'stretch_scroll_indicator.dart';

/// A scroll behavior that provides platform-appropriate overscroll effects.
///
/// It uses the "stretch" overscroll effect on Android for a modern,
/// fluid feel, and defaults to the standard behavior on other platforms
/// (e.g., bouncing on iOS, glowing on desktop).
class AppScrollBehavior extends ScrollBehavior {
  const AppScrollBehavior();
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Use getPlatform to respect platform overrides in tests and platform-specific
    // design choices.
    switch (getPlatform(context)) {
      case TargetPlatform.android:
        // Use the stretch overscroll indicator for a modern Android feel.
        return StretchingOverscrollIndicator(
          axisDirection: details.direction,
          child: child,
        );
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        // For other platforms, use the default behavior. This will be a
        // bouncing effect on iOS and a glowing effect on others.
        return super.buildOverscrollIndicator(context, child, details);
    }
  }
}
