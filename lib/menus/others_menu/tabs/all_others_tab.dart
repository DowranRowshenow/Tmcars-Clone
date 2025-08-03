import 'package:flutter/material.dart';

import '../../../components/no_connection.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/popular_product_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/server.dart';
import '../../home_menu/components/popular_product_card.dart';

class AllOthersTab extends StatefulWidget {
  const AllOthersTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllOthersTabState createState() => _AllOthersTabState();
}

class _AllOthersTabState extends State<AllOthersTab> {
  String searchText = "";
  final TextEditingController searchBarController = TextEditingController();
  late Future<List<PopularProduct>> _popularProductsFuture;

  @override
  void initState() {
    super.initState();
    _loadPopularProducts();
  }

  void _loadPopularProducts() {
    _popularProductsFuture = Server.getSettings();
    if (mounted) setState(() {});
  }

  Future<void> _handleRefresh() async {
    _loadPopularProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.5)),
          ),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: searchBarController,
                  autocorrect: false,
                  style: const TextStyle(fontSize: 20),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(
                    hintText: Localizations.of<AppLocalizations>(
                      context,
                      AppLocalizations,
                    )!.search,
                  ),
                  onChanged: (String value) {
                    if (value.length <= 255) {
                      searchText = value;
                    } else {
                      searchBarController.text = searchText;
                    }
                  },
                ),
              ),
              const Icon(Icons.search),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<PopularProduct>>(
            future: _popularProductsFuture,
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<List<PopularProduct>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return NoConnection(onTap: () => _handleRefresh());
                  } else if (snapshot.hasData) {
                    final List<PopularProduct> popularProducts = snapshot.data!;
                    if (popularProducts.isEmpty) {
                      return NoConnection(onTap: () => _handleRefresh());
                    }
                    return RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: ListView.builder(
                        itemExtent: Constants.popularProductItemExtent,

                        itemCount: popularProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PopularProductCard(
                            key: ValueKey<int>(popularProducts[index].id),
                            product: popularProducts[index],
                          );
                        },
                      ),
                    );
                  }
                  // Fallback, should ideally not be reached if other states are handled.
                  return Center(
                    child: Text(
                      Localizations.of<AppLocalizations>(
                        context,
                        AppLocalizations,
                      )!.somethingWentWrong,
                    ),
                  );
                },
          ),
        ),
      ],
    );
  }
}
