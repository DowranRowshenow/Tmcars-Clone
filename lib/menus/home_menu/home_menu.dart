import 'package:flutter/material.dart';

import '../../components/no_connection.dart';
import '../../utils/constants.dart';
import '../../utils/server.dart';
import '../../l10n/app_localizations.dart';
import '../../models/popular_product_model.dart';
import 'components/popular_product_card.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
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
    return FutureBuilder<List<PopularProduct>>(
      future: _popularProductsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return NoConnection(onTap: _handleRefresh);
        } else if (snapshot.hasData) {
          final popularProducts = snapshot.data!;
          if (popularProducts.isEmpty) {
            return NoConnection(onTap: _handleRefresh);
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
        return Center(
          child: Text(AppLocalizations.of(context)!.somethingWentWrong),
        );
      },
    );
  }
}
