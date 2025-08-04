import 'package:flutter/material.dart';

import '../../components/no_connection.dart';
import '../../l10n/app_localizations.dart';
import '../../models/app_settings_model.dart';
import '../../utils/constants.dart';
import '../../utils/server.dart';
import 'components/popular_product_card.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  Future<List<DashFeaturedItem>> _handleRefresh() async {
    return await Server.getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DashFeaturedItem>>(
      future: _handleRefresh(),
      builder:
          (
            BuildContext context,
            AsyncSnapshot<List<DashFeaturedItem>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return NoConnection(onTap: _handleRefresh);
            } else if (snapshot.hasData) {
              final List<DashFeaturedItem> dashFeaturedItems = snapshot.data!;
              if (dashFeaturedItems.isEmpty) {
                return NoConnection(onTap: _handleRefresh);
              }
              return RefreshIndicator(
                onRefresh: _handleRefresh,
                child: ListView.builder(
                  itemExtent: Constants.popularProductItemExtent,
                  itemCount: dashFeaturedItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PopularProductCard(
                      key: ValueKey<int>(dashFeaturedItems[index].id),
                      product: dashFeaturedItems[index],
                    );
                  },
                ),
              );
            }
            return Center(
              child: Text(
                Localizations.of<AppLocalizations>(
                  context,
                  AppLocalizations,
                )!.somethingWentWrong,
              ),
            );
          },
    );
  }
}
