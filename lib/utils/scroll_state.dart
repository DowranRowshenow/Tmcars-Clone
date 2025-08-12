import 'package:flutter/material.dart';

class ScrollState {
  final bool showTitle;
  final bool background;

  ScrollState({required this.showTitle, required this.background});

  static const double expandedHeight = 250.0;
  static const double offset = 30.0;

  static ScrollState initial = ScrollState(showTitle: false, background: false);

  void onScroll(
    ValueNotifier<ScrollState> scrollStateNotifier,
    ScrollController scrollController,
    double toolbarHeight,
  ) {
    if (!scrollController.hasClients) {
      return;
    }
    if (scrollController.offset >= expandedHeight) {
      return;
    }
    final ScrollState newState = scrollStateNotifier.value.copyWith(
      showTitle:
          scrollController.offset >=
          ScrollState.expandedHeight - toolbarHeight * 2,
      background:
          scrollController.offset >= ScrollState.expandedHeight - toolbarHeight,
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
