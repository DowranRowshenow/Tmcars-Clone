import 'dart:async';

import 'package:flutter/material.dart';

import '../../../components/fab_scroller.dart';
import '../../../components/no_connection.dart';
import '../../../components/no_result.dart';
import '../../../components/scroll/low_friction_scroll_physics.dart';
import '../../../components/search_product_bar.dart';
import '../../../models/car_model.dart';
import '../../../models/car_query_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/loading_controller.dart';
import '../../../utils/server.dart';
import '../components/car_card.dart';

class AllCarsTab extends StatefulWidget {
  const AllCarsTab({
    super.key,
    required this.query,
    required this.searchBarController,
  });
  final ValueNotifier<CarQuery> query;
  final TextEditingController searchBarController;

  @override
  State<AllCarsTab> createState() => _AllCarsTabState();
}

class _AllCarsTabState extends State<AllCarsTab>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<List<Car>> _cars = ValueNotifier<List<Car>>(<Car>[]);
  final LoadingController _loadingController = LoadingController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeData();
    widget.query.addListener(_onQueryChange);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _cars.dispose();
    _scrollController.removeListener(_onScroll);
    widget.query.removeListener(_onQueryChange);
    _scrollController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  void _onQueryChange() {
    _loadCars(refresh: true);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_loadingController.isLoading.value &&
        _loadingController.hasMore.value) {
      _loadCars();
    }
  }

  Future<void> _initializeData() async {
    // First, try to load articles from local storage to show data quickly.
    /*
    if (widget.isCacheEnabled) {
      Storage.instance.getCarsByCategory(widget.category?.id ?? 0).then((
        List<Car> value,
      ) {
        if (mounted && value.isNotEmpty) {
          _cars.value = value;
        }
      });
    }*/

    await _loadCars(refresh: true);
  }

  Future<void> _loadCars({bool refresh = false}) async {
    if (_loadingController.isLoading.value || !mounted) return;
    _loadingController.isLoading.value = true;
    if (refresh) {
      _loadingController.hasError.value = false;
      _loadingController.hasMore.value = true;
      widget.query.value.offset = 0;
    }

    final List<Car>? newCars = await Server.getCars(widget.query.value);
    if (!mounted) return;

    if (newCars == null) {
      _loadingController.hasError.value = true;
    } else {
      if (refresh) {
        _cars.value = newCars;
      } else {
        _cars.value = <Car>[..._cars.value, ...newCars];
      }

      widget.query.value.offset = 0;
      _loadingController.hasMore.value = newCars.length >= 40;
      _loadingController.hasError.value = false;
      if (newCars.isNotEmpty) {
        // TODO: Consider caching only first 40 Item
        // Storage.instance.cacheCars(widget.category?.id, _cars.value);
      }
    }
    _loadingController.isLoading.value = false;
  }

  Future<void> _handleRefresh() async {
    await _loadCars(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: SearchProductBar.height,
        elevation: 1.0,
        backgroundColor: Theme.of(
          context,
        ).extension<AppColors>()!.themedSurface,
        automaticallyImplyLeading: false,
        title: SearchProductBar(
          searchBarController: widget.searchBarController,
          query: widget.query,
          onTap: () {},
        ),
      ),
      floatingActionButton: ValueListenableBuilder<List<Car>>(
        valueListenable: _cars,
        builder: (BuildContext context, List<Car> value, Widget? child) {
          if (value.isNotEmpty) {
            return FabScroller(scrollController: _scrollController);
          }
          return const SizedBox.shrink();
        },
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ValueListenableBuilder<List<Car>>(
          valueListenable: _cars,
          builder: (BuildContext context, List<Car> value, Widget? child) {
            if (_loadingController.hasError.value && _cars.value.isEmpty) {
              return NoConnection(onTap: _handleRefresh);
            }
            // Show a loading indicator on initial load.
            else if (_loadingController.isLoading.value &&
                _cars.value.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            // If loading is finished and there are no articles, show NoResult.
            else if (_cars.value.isEmpty &&
                !_loadingController.isLoading.value) {
              return const NoResult();
            }
            return ListView.builder(
              physics: const LowFrictionScrollPhysics(),
              itemExtent: Constants.articleItemExtent,
              controller: _scrollController,
              itemCount:
                  _cars.value.length +
                  (_loadingController.hasMore.value ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index < _cars.value.length) {
                  return CarCard(
                    key: ValueKey<int>(_cars.value[index].id),
                    car: _cars.value[index],
                  );
                } else {
                  // Show loading indicator at the bottom
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
