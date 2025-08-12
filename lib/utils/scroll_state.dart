import 'package:flutter/material.dart';

class ScrollState {
  final bool showTitle;
  final bool background;

  const ScrollState({required this.showTitle, required this.background});

  static const double expandedHeight = 250.0;
  static const double offset = 30.0;

  static const ScrollState initial = ScrollState(
    showTitle: false,
    background: false,
  );

  static void onScroll(
    ValueNotifier<ScrollState> scrollStateNotifier,
    ScrollController scrollController,
  ) {
    if (!scrollController.hasClients) return;

    final ScrollState newState = scrollStateNotifier.value.copyWith(
      showTitle:
          scrollController.offset >=
          ScrollState.expandedHeight - kToolbarHeight * 2,
      background:
          scrollController.offset >=
          ScrollState.expandedHeight - kToolbarHeight,
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
      showTitle: showTitle ?? this.showTitle,
      background: background ?? this.background,
    );
  }
}
