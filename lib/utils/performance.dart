import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart' show kDebugMode, VoidCallback;
import 'package:flutter/material.dart';

/// A collection of utilities for performance measurement and optimization.
class PerformanceUtils {
  static final Map<String, Timer> _timers = <String, Timer>{};
  static final Map<String, DateTime> _startTimes = <String, DateTime>{};

  /// Start performance measurement
  ///
  /// This also creates a timeline event in Flutter DevTools for visual profiling.
  static void startTimer(String name) {
    if (kDebugMode) {
      // Using developer.Timeline allows integration with Flutter's DevTools.
      developer.Timeline.startSync(name);
      _startTimes[name] = DateTime.now();
    }
  }

  /// End performance measurement and log
  static void endTimer(String name) {
    if (kDebugMode && _startTimes.containsKey(name)) {
      final Duration duration = DateTime.now().difference(_startTimes[name]!);
      // Finish the timeline event so it appears in DevTools.
      developer.Timeline.finishSync();
      developer.log('Performance: $name took ${duration.inMilliseconds}ms');
      _startTimes.remove(name);
    }
  }

  /// Debounce function calls to prevent excessive executions
  static Timer? debounce(
    String key,
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    _timers[key]?.cancel();
    _timers[key] = Timer(duration, callback);
    return _timers[key];
  }

  /// Cancel a specific debounced function
  static void cancelDebounce(String key) {
    _timers[key]?.cancel();
    _timers.remove(key);
  }

  /// Clear all debounced functions
  static void clearAllDebounce() {
    for (final Timer timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
  }

  /// Memory optimization: Clear caches when memory pressure is detected
  static void clearCaches() {
    if (kDebugMode) {
      developer.log('Clearing caches due to memory pressure');
    }
    // Add cache clearing logic here
  }

  /// Check if device is low on memory
  static bool isLowMemory() {
    // This is a placeholder - in a real app you'd check actual memory usage
    return false;
  }
}

/// Mixin for performance monitoring in widgets
mixin PerformanceMixin<T extends StatefulWidget> on State<T> {
  String get performanceTag => widget.runtimeType.toString();

  @override
  void initState() {
    super.initState();
    PerformanceUtils.startTimer('$performanceTag.init');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    PerformanceUtils.endTimer('$performanceTag.init');
  }

  @override
  void dispose() {
    PerformanceUtils.clearAllDebounce();
    super.dispose();
  }
}
