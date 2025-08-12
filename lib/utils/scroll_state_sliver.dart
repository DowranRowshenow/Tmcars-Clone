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
    double toolbarHeight,
  ) {
    if (!scrollController.hasClients ||
        scrollController.offset >= expandedHeight) {
      return;
    }

    double newTop = (expandedHeight - offset) - scrollController.offset;
    if (newTop < toolbarHeight) newTop = toolbarHeight;

    final ScrollState newState = scrollStateNotifier.value.copyWith(
      fabTop: newTop,
      fabVisible: newTop > toolbarHeight + 1,
      showTitle: scrollController.offset >= expandedHeight - toolbarHeight * 2,
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
