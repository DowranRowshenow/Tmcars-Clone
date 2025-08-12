import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../components/app_bar_image.dart';
import '../../components/back_icon_button.dart';
import '../../components/should_register_dialog.dart';
import '../../l10n/app_localizations.dart';
import '../../models/car_detail_model.dart';
import '../../models/car_model.dart';
import '../../providers/navigation.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/scroll_state.dart';
import '../../utils/server.dart';
import 'components/car_detail_content.dart';

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
  late VoidCallback _scrollListener;

  @override
  void initState() {
    super.initState();
    _loadCar();
    _scrollListener = () => _scrollStateNotifier.value.onScroll(
      _scrollStateNotifier,
      _scrollController,
      MediaQuery.of(context).padding.top + kToolbarHeight,
    );
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _scrollStateNotifier.dispose();
    _carDetailNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadCar() async {
    final CarDetail? carDetail = await Server.getCar(widget.car.id);
    if (mounted) _carDetailNotifier.value = carDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ValueListenableBuilder<ScrollState>(
          valueListenable: _scrollStateNotifier,
          builder:
              (BuildContext context, ScrollState scrollState, Widget? child) {
                return AppBar(
                  elevation: scrollState.background ? 1.0 : 0,
                  backgroundColor: scrollState.background
                      ? Theme.of(context).appBarTheme.backgroundColor
                      : Colors.transparent,
                  leading: buildBackIconButton(context),
                  title: AnimatedOpacity(
                    opacity: scrollState.showTitle ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Text(_carDetailNotifier.value?.getTitle() ?? ""),
                  ),
                  actions: <Widget>[
                    AnimatedOpacity(
                      opacity: scrollState.showTitle ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        splashRadius: Constants.splashRadius,
                        icon: const Icon(Icons.thumb_up_outlined),
                        onPressed: () => shouldRegisterDialog(context: context),
                      ),
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
                                      ShareParams(
                                        text: carDetail?.shareSiteUrl,
                                      ),
                                    );
                                    break;
                                }
                              },
                            );
                          },
                    ),
                  ],
                );
              },
        ),
      ),
      body: ValueListenableBuilder<CarDetail?>(
        valueListenable: _carDetailNotifier,
        builder: (BuildContext context, CarDetail? carDetail, Widget? child) {
          if (carDetail == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: <Widget>[
              SingleChildScrollView(
                controller: _scrollController,
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: ScrollState.expandedHeight,
                          child: AppBarImage(
                            onTapImage: () {
                              context.read<NavigationManager>().setScreen(
                                context,
                                ScreenState.imageView,
                                imageUrls: carDetail.fullImgs,
                              );
                            },
                            imageUrls: carDetail.imgs,
                          ),
                        ),
                        CarDetailContent(
                          carDetail: carDetail,
                          car: widget.car,
                          languageCode: widget.languageCode,
                        ),
                      ],
                    ),
                    ValueListenableBuilder<ScrollState>(
                      valueListenable: _scrollStateNotifier,
                      builder:
                          (
                            BuildContext context,
                            ScrollState scrollState,
                            Widget? child,
                          ) {
                            return Positioned(
                              right: 20,
                              top:
                                  ScrollState.expandedHeight -
                                  ScrollState.offset,
                              child: AnimatedScale(
                                scale: !scrollState.showTitle ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                                child: FloatingActionButton(
                                  onPressed: Constants.isRegistered
                                      ? null
                                      : () => shouldRegisterDialog(
                                          context: context,
                                        ),
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.thumb_up_outlined,
                                    color: !scrollState.showTitle
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
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Constants.colorPrimary,
                            ),
                          ),
                          child: const Text(
                            "Jaň etmek",
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.greenAccent,
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "SMS ugratmak",
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
