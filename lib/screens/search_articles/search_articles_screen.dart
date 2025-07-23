import 'package:flutter/material.dart';

import '../../menus/articles_menu/tabs/articles_tab.dart';
import '../../utils/constants.dart';
import '../../l10n/app_localizations.dart';

class SearchArticlesScreen extends StatefulWidget {
  const SearchArticlesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchArticlesScreenState createState() => _SearchArticlesScreenState();
}

class _SearchArticlesScreenState extends State<SearchArticlesScreen> {
  final TextEditingController searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchBarController,
          autocorrect: false,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          keyboardType: TextInputType.text,
          cursorColor: Colors.white,
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(color: Colors.grey.shade200),
            hintText: AppLocalizations.of(context)!.search,
          ),
          onChanged: (value) {
            if (value.length <= 50) {
              setState(() {}); // This will rebuild the widget on every change
            } else {
              // Optionally prevent input longer than 50 chars
              searchBarController.text = searchBarController.text.substring(
                0,
                50,
              );
              searchBarController.selection = TextSelection.fromPosition(
                TextPosition(offset: searchBarController.text.length),
              );
            }
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          splashRadius: Constants.splashRadius,
          splashColor: Colors.transparent,
        ),
        actions: [
          searchBarController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    searchBarController.clear();
                    setState(() {});
                  },
                  splashRadius: Constants.splashRadius,
                  icon: const Icon(Icons.close),
                  splashColor: Colors.transparent,
                )
              : const SizedBox(width: 20),
        ],
      ),
      body: searchBarController.text.isEmpty
          ? Container()
          : ArticlesTab(mask: searchBarController.text),
    );
  }
}
