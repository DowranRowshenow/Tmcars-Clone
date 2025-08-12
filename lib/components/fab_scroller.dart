import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/constants.dart'; // Ensure this path is correct for your Constants

class FabScroller extends StatefulWidget {
  const FabScroller({
    super.key,
    required this.scrollController,
    this.delay = const Duration(milliseconds: 1500),
  });

  final ScrollController scrollController;
  final Duration delay; // Allow customization of the hide delay

  @override
  State<FabScroller> createState() => _FabScrollerState();
}

class _FabScrollerState extends State<FabScroller> {
  final ValueNotifier<bool> _fabVisibleNotifier = ValueNotifier<bool>(false);
  double _lastScrollOffset = 0.0;
  Timer? _hideFabTimer;

  @override
  void initState() {
    super.initState();
    // Schedule adding listeners after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Ensure the widget is still in the tree
        // Only add listeners if the controller is attached
        if (widget.scrollController.hasClients) {
          widget.scrollController.addListener(_onScroll);
          widget.scrollController.position.isScrollingNotifier.addListener(
            _handleScrollActivityChange,
          );
        } else {
          // Fallback/Warning: If controller is not attached even after first frame,
          // it might indicate an issue with how the controller is passed or used.
          debugPrint(
            'FabScroller: ScrollController not attached after initial frame.',
          );
        }
      }
    });
  }

  @override
  void dispose() {
    // Only remove listeners if the controller was attached
    if (widget.scrollController.hasClients && mounted) {
      widget.scrollController.removeListener(_onScroll);
      widget.scrollController.position.isScrollingNotifier.removeListener(
        _handleScrollActivityChange,
      );
    }
    _fabVisibleNotifier.dispose();
    _hideFabTimer?.cancel();
    super.dispose();
  }

  // New method to handle when scrolling starts or stops
  void _handleScrollActivityChange() {
    // If scrolling has started (from idle state)
    if (widget.scrollController.position.isScrollingNotifier.value) {
      _hideFabTimer?.cancel(); // Cancel any pending hide timer
    } else {
      // If scrolling has stopped (transitioned to idle state)
      // And the FAB is visible and we're not at the very top
      if (_fabVisibleNotifier.value && widget.scrollController.offset > 0) {
        _startHideTimer();
      }
    }
  }

  void _onScroll() {
    if (!widget.scrollController.hasClients || !mounted) return;

    final double currentOffset = widget.scrollController.offset;
    final bool shouldBeVisible = currentOffset <= 0
        ? false // Hide FAB at the very top of the scroll view
        : currentOffset < _lastScrollOffset; // Show FAB when scrolling up

    // Early return if the FAB's visibility state is already correct
    if (_fabVisibleNotifier.value == shouldBeVisible) {
      _lastScrollOffset = currentOffset;
      return;
    }

    _fabVisibleNotifier.value = shouldBeVisible;
    _lastScrollOffset = currentOffset;

    if (shouldBeVisible) {
      // If we're showing the FAB, cancel any pending hide timer
      _hideFabTimer?.cancel();
    }
  }

  void _startHideTimer() {
    _hideFabTimer
        ?.cancel(); // Cancel any existing timer before starting a new one
    _hideFabTimer = Timer(widget.delay, () {
      if (mounted && _fabVisibleNotifier.value) {
        _fabVisibleNotifier.value = false; // Hide FAB after delay
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _fabVisibleNotifier,
      builder: (BuildContext context, bool isVisible, Widget? child) {
        return AnimatedScale(
          scale: isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          child: FloatingActionButton(
            heroTag: Object(),
            mini: true,
            backgroundColor: Constants.colorPrimary,
            onPressed: () {
              // Ensure controller has clients before animating
              if (widget.scrollController.hasClients && mounted) {
                widget.scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInQuad,
                );
              }
            },
            child: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
          ),
        );
      },
    );
  }
}
