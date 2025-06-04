import 'package:flutter/material.dart';

import '../../../helper/constants.dart';
import '../../../helper/server.dart';
import '../../../helper/size_config.dart';
import '../../../models/Product.dart';
import '../../../components/product_card.dart';

class AllOthersTab extends StatefulWidget {
  const AllOthersTab({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AllOthersTabState createState() => _AllOthersTabState();
}

class _AllOthersTabState extends State<AllOthersTab> {
  String searchText = "";
  late List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(getProportionateScreenHeight(10)),
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
                  decoration: const InputDecoration.collapsed(
                    hintText: "Gözleg",
                    hintStyle: TextStyle(),
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
          child: FutureBuilder<List<Product>>(
            future: Server.getProducts(name: searchBarController.text),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                products = snapshot.data as List<Product>;
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ...List.generate(products.length, (index) {
                          return ProductCard(product: products[index]);
                        }),
                      ],
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(height: getProportionateScreenWidth(40)),
                    const Center(child: CircularProgressIndicator()),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
