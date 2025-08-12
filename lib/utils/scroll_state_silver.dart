import 'package:flutter/material.dart';

class ScrollState {
  final double fabTop;
  final bool fabVisible;
  final bool showTitle;

  const ScrollState({
    required this.fabTop,
    required this.fabVisible,
    required this.showTitle,
  });

  static const double expandedHeight = 250.0;
  static const double offset = 30.0;

  static const ScrollState initial = ScrollState(
    fabTop: expandedHeight - offset,
    fabVisible: true,
    showTitle: false,
  );

  static void onScroll(
    ValueNotifier<ScrollState> scrollStateNotifier,
    ScrollController scrollController,
  ) {
    final double offset = scrollController.hasClients
        ? scrollController.offset
        : 0.0;

    double newTop = (ScrollState.expandedHeight - ScrollState.offset) - offset;
    if (newTop < kToolbarHeight) newTop = kToolbarHeight;
    bool newVisible = newTop > kToolbarHeight + 1;

    final bool shouldShowTitle =
        scrollController.hasClients &&
        scrollController.offset >= ScrollState.expandedHeight - kToolbarHeight;

    final ScrollState newState = scrollStateNotifier.value.copyWith(
      fabTop: newTop,
      fabVisible: newVisible,
      showTitle: shouldShowTitle,
    );

    if (scrollStateNotifier.value != newState) {
      scrollStateNotifier.value = newState;
    }
  }

  ScrollState copyWith({
    double? fabTop,
    bool? fabVisible,
    bool? showTitle,
    bool? background,
  }) {
    return ScrollState(
      fabTop: fabTop ?? this.fabTop,
      fabVisible: fabVisible ?? this.fabVisible,
      showTitle: showTitle ?? this.showTitle,
    );
  }
}
