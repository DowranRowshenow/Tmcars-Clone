import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../components/app_bar_image.dart';
import '../../components/back_icon_button.dart';
import '../../components/scroll/glowless_scroll_behavior.dart';
import '../../components/scroll/low_friction_scroll_physics.dart';
import '../../components/should_register_dialog.dart';
import '../../l10n/app_localizations.dart';
import '../../models/car_detail_model.dart';
import '../../models/car_model.dart';
import '../../providers/navigation.dart';
import '../../providers/themes.dart';
import '../../utils/constants.dart';
import '../../utils/server.dart';
import 'components/car_detail_content.dart';

/// Represents the scroll state for the Car detail screen
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

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({
    super.key,
    required this.car,
    required this.languageCode,
  });
  final Car car;
  final String languageCode;

  @override
  // ignore: library_private_types_in_public_api
  _CarDetailScreenState createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<CarDetail?> _carDetailNotifier =
      ValueNotifier<CarDetail?>(null);
  final ValueNotifier<ScrollState> _scrollStateNotifier =
      ValueNotifier<ScrollState>(ScrollState.initial);

  @override
  void initState() {
    super.initState();
    _loadCar();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _scrollStateNotifier.dispose();
    _carDetailNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadCar() async {
    final CarDetail? carDetail = await Server.getCar(widget.car.id);
    if (mounted) _carDetailNotifier.value = carDetail;
  }

  void _onScroll() {
    final double offset = _scrollController.hasClients
        ? _scrollController.offset
        : 0.0;

    double newTop = (ScrollState.expandedHeight - ScrollState.offset) - offset;
    if (newTop < kToolbarHeight) newTop = kToolbarHeight;
    bool newVisible = newTop > kToolbarHeight + 1;

    final bool shouldShowTitle =
        _scrollController.hasClients &&
        _scrollController.offset >= ScrollState.expandedHeight - kToolbarHeight;

    final ScrollState newState = _scrollStateNotifier.value.copyWith(
      fabTop: newTop,
      fabVisible: newVisible,
      showTitle: shouldShowTitle,
    );

    if (_scrollStateNotifier.value != newState) {
      _scrollStateNotifier.value = newState;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            scrollBehavior: GlowlessScrollBehavior(),
            physics: const LowFrictionScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: ScrollState.expandedHeight,
                pinned: true,
                floating: false,
                snap: false,
                title: ValueListenableBuilder<ScrollState>(
                  valueListenable: _scrollStateNotifier,
                  builder:
                      (
                        BuildContext context,
                        ScrollState scrollState,
                        Widget? child,
                      ) {
                        return AnimatedOpacity(
                          opacity: scrollState.showTitle ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: Text(
                            _carDetailNotifier.value?.getTitle() ?? "",
                          ),
                        );
                      },
                ),
                leading: buildBackIconButton(context),
                actions: <Widget>[
                  ValueListenableBuilder<ScrollState>(
                    valueListenable: _scrollStateNotifier,
                    builder:
                        (
                          BuildContext context,
                          ScrollState scrollState,
                          Widget? child,
                        ) {
                          return AnimatedOpacity(
                            opacity: scrollState.showTitle ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: IconButton(
                              splashColor: Colors.transparent,
                              splashRadius: Constants.splashRadius,
                              icon: const Icon(Icons.thumb_up_outlined),
                              onPressed: () =>
                                  shouldRegisterDialog(context: context),
                            ),
                          );
                        },
                  ),
                  ValueListenableBuilder<CarDetail?>(
                    valueListenable: _carDetailNotifier,
                    builder:
                        (
                          BuildContext context,
                          CarDetail? carDetail,
                          Widget? child,
                        ) {
                          return PopupMenuButton<int>(
                            tooltip: "",
                            menuPadding: const EdgeInsets.all(0),
                            color: Theme.of(
                              context,
                            ).extension<AppColors>()!.themedSurface,
                            splashRadius: Constants.splashRadius,
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                            ),
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<int>>[
                                  PopupMenuItem<int>(
                                    value: 0,
                                    child: Text(
                                      Localizations.of<AppLocalizations>(
                                        context,
                                        AppLocalizations,
                                      )!.shareLink,
                                    ),
                                  ),
                                ],
                            onSelected: (int value) {
                              switch (value) {
                                case 0:
                                  SharePlus.instance.share(
                                    ShareParams(text: carDetail?.shareSiteUrl),
                                  );
                                  break;
                              }
                            },
                          );
                        },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: ValueListenableBuilder<CarDetail?>(
                    valueListenable: _carDetailNotifier,
                    builder:
                        (
                          BuildContext context,
                          CarDetail? carDetail,
                          Widget? child,
                        ) {
                          return carDetail == null
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : AppBarImage(
                                  onTapImage: () {
                                    context.read<NavigationManager>().setScreen(
                                      context,
                                      ScreenState.imageView,
                                      imageUrls: carDetail.fullImgs,
                                    );
                                  },
                                  imageUrls: carDetail.imgs,
                                );
                        },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ValueListenableBuilder<CarDetail?>(
                    valueListenable: _carDetailNotifier,
                    builder:
                        (
                          BuildContext context,
                          CarDetail? carDetail,
                          Widget? child,
                        ) {
                          return CarDetailContent(
                            carDetail: carDetail,
                            car: widget.car,
                            languageCode: widget.languageCode,
                          );
                        },
                  ),
                ),
              ),
            ],
          ),
          ValueListenableBuilder<ScrollState>(
            valueListenable: _scrollStateNotifier,
            builder:
                (BuildContext context, ScrollState scrollState, Widget? child) {
                  return Positioned(
                    top: scrollState.fabTop,
                    right: 30,
                    child: AnimatedScale(
                      scale: scrollState.fabVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      child: FloatingActionButton(
                        onPressed: Constants.isRegistered
                            ? null
                            : () => shouldRegisterDialog(context: context),
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.thumb_up_outlined,
                          color: scrollState.fabVisible
                              ? Colors.blueGrey
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  );
                },
          ),
        ],
      ),
    );
  }
}
