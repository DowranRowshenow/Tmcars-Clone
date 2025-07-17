import 'package:flutter/material.dart';

import '../../helper/constants.dart' as constants;
import '../../l10n/app_localizations.dart';

class SearchNewsScreen extends StatefulWidget {
  const SearchNewsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchNewsScreenState createState() => _SearchNewsScreenState();
}

class _SearchNewsScreenState extends State<SearchNewsScreen> {
  TextEditingController searchBarController = TextEditingController();
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchBarController,
          autocorrect: false,
          style: const TextStyle(fontSize: 20),
          keyboardType: TextInputType.text,
          decoration: InputDecoration.collapsed(
            hintText: AppLocalizations.of(context)!.search,
          ),
          onChanged: (value) {
            if (value.length <= 50) {
              searchText = value;
              setState(() {});
            } else {
              searchBarController.text = searchText;
            }
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          splashRadius: constants.splashRadius,
          splashColor: Colors.transparent,
        ),
        actions: [
          searchBarController.text != ""
              ? IconButton(
                  onPressed: () {
                    searchBarController.text = "";
                    setState(() {});
                  },
                  splashRadius: constants.splashRadius,
                  icon: const Icon(Icons.close),
                  splashColor: Colors.transparent,
                )
              : SizedBox(width: 20, child: null),
        ],
      ),
      body: SingleChildScrollView(child: Container()),
    );
  }
}
