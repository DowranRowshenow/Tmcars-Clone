import 'package:flutter/foundation.dart';

class LoadingController {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> hasError = ValueNotifier<bool>(false);
  final ValueNotifier<bool> hasMore = ValueNotifier<bool>(false);

  /// Reset all download states to initial values
  void reset() {
    isLoading.value = false;
    hasError.value = false;
    hasMore.value = false;
  }

  void dispose() {
    isLoading.dispose();
    hasError.dispose();
    hasMore.dispose();
  }
}
