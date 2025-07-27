import 'package:flutter/material.dart';

import '../../../models/popular_product_model.dart';
import '../../../components/no_connection.dart';
import '../../../utils/constants.dart';
import '../../../utils/server.dart';
import '../../../l10n/app_localizations.dart';
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
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.5)),
          ),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: searchBarController,
                  autocorrect: false,
                  style: const TextStyle(fontSize: 20),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(
                    hintText: AppLocalizations.of(context)!.search,
                  ),
                  onChanged: (value) {
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
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return NoConnection(onTap: () => _handleRefresh());
              } else if (snapshot.hasData) {
                final popularProducts = snapshot.data!;
                if (popularProducts.isEmpty) {
                  return NoConnection(onTap: () => _handleRefresh());
                }
                return RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: ListView.builder(
                    itemExtent: Constants.popularProductItemExtent,
                    shrinkWrap: true,
                    itemCount: popularProducts.length,
                    itemBuilder: (context, index) {
                      return PopularProductCard(
                        key: ValueKey(popularProducts[index].id),
                        product: popularProducts[index],
                      );
                    },
                  ),
                );
              }
              // Fallback, should ideally not be reached if other states are handled.
              return Center(
                child: Text(AppLocalizations.of(context)!.somethingWentWrong),
              );
            },
          ),
        ),
      ],
    );
  }
}
