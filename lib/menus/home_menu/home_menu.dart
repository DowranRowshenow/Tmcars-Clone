import 'package:flutter/material.dart';
import 'package:tmcars/components/no_connection.dart';

import 'components/popular_product_card.dart';
import '../../helper/server.dart';
import '../../models/PopularProduct.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

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
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _loadPopularProducts();
    });
    // The FutureBuilder will listen to the new future.
    // We can await it here if we need to do something after the refresh completes,
    // but for just updating the UI, setState is enough.
    await _popularProductsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PopularProduct>>(
      future: _popularProductsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              // Consider const if color is static or from theme
              // Consider using Theme.of(context).primaryColor if you want themed loading
              color: Theme.of(context).primaryColorDark,
            ),
          );
        } else if (snapshot.hasError) {
          // Your Server.getSettings() currently returns an empty list on error,
          // so this block might not be hit unless Server.getSettings() is changed to throw.
          return NoConnection(
            onTap: () {
              setState(() {
                _handleRefresh();
              });
            },
          );
        } else if (snapshot.hasData) {
          final popularProducts = snapshot.data!;
          if (popularProducts.isEmpty) {
            return RefreshIndicator(
              onRefresh: _handleRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: const Center(
                      child: Text('No popular products found.')), // Made const
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _handleRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListView.builder(
                shrinkWrap: true, // Important when inside another scrollable
                physics:
                    const NeverScrollableScrollPhysics(), // Delegate scrolling
                itemCount: popularProducts.length,
                itemBuilder: (context, index) {
                  return PopularProductCard(product: popularProducts[index]);
                },
              ),
            ),
          );
        }
        // Fallback, should ideally not be reached if other states are handled.
        return const Center(child: Text("Something went wrong."));
      },
    );
  }
}
