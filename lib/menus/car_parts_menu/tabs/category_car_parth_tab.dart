import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/car_product_filter_model.dart';
import '../../../models/car_query_model.dart';
import '../../../utils/server.dart';

class CategoryCarPartsTab extends StatefulWidget {
  const CategoryCarPartsTab({
    super.key,
    required this.tabController,
    required this.query,
    required this.searchBarController,
  });
  final TextEditingController searchBarController;
  final TabController tabController;
  final ValueNotifier<CarQuery> query;

  @override
  State<CategoryCarPartsTab> createState() => _CategoryCarPartsTabState();
}

class _CategoryCarPartsTabState extends State<CategoryCarPartsTab>
    with AutomaticKeepAliveClientMixin {
  Future<List<CarProductFilter>> _future() {
    return Server.getCarProductFilter(const CarProductFilter(onlyBrand: true));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<CarProductFilter>>(
      future: _future(),
      builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
        if (snapshot.hasData) {
          final List<CarProductFilter> items =
              snapshot.data as List<CarProductFilter>;
          return ListView.builder(
            itemCount: items.length,
            itemExtent: 55.0,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                minVerticalPadding: 0,
                contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                titleAlignment: ListTileTitleAlignment.center,
                key: ValueKey<int>(index),
                leading: CachedNetworkImage(
                  width: 25.0,
                  height: 25.0,
                  imageUrl: items[index].imgUrl ?? "",
                ),
                title: Text(
                  "${items[index].filterName ?? ''} (${items[index].productCount})",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  widget.query.value.filterId = items[index].id;
                  widget.query.value = widget.query.value.copyWith();
                  widget.searchBarController.text =
                      items[index].filterName ?? "";
                  widget.tabController.animateTo(0);
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
