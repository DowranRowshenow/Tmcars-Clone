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
  static const double offset = 0.0;

  static const ScrollState initial = ScrollState(
    fabTop: expandedHeight - offset,
    fabVisible: true,
    showTitle: false,
  );

  ScrollState copyWith({double? fabTop, bool? fabVisible, bool? showTitle}) {
    return ScrollState(
      fabTop: fabTop ?? this.fabTop,
      fabVisible: fabVisible ?? this.fabVisible,
      showTitle: showTitle ?? this.showTitle,
    );
  }
}
