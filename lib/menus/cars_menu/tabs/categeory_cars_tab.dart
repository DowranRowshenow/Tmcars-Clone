import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/car_product_filter_model.dart';
import '../../../models/car_query_model.dart';
import '../../../utils/server.dart';

class CategoryCarsTab extends StatelessWidget {
  const CategoryCarsTab({
    super.key,
    required this.tabController,
    required this.query,
  });
  final TabController tabController;
  final ValueNotifier<CarQuery> query;

  Future<List<CarProductFilter>> _future() {
    return Server.getCarProductFilter(const CarProductFilter(onlyBrand: true));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CarProductFilter>>(
      future: _future(),
      builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
        if (snapshot.hasData) {
          final List<CarProductFilter> items =
              snapshot.data as List<CarProductFilter>;
          return ListView.builder(
            itemCount: items.length,
            itemExtent: 50.0,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                minVerticalPadding: 0,
                contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                titleAlignment: ListTileTitleAlignment.center,
                key: ValueKey<int>(index),
                leading: CachedNetworkImage(
                  width: 35.0,
                  height: 35.0,
                  imageUrl: items[index].imgUrl ?? "",
                ),
                title: Text(
                  "  ${items[index].filterName ?? ''} (${items[index].productCount})",
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  query.value.filterId = items[index].id;
                  query.value = query.value.copyWith();
                  tabController.animateTo(0);
                },
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
