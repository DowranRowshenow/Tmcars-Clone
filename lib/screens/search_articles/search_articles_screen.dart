import 'package:flutter/material.dart';
import 'dart:async';

import '../../menus/articles_menu/tabs/articles_tab.dart';
import '../../utils/constants.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/themes.dart';

class SearchArticlesScreen extends StatefulWidget {
  const SearchArticlesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchArticlesScreenState createState() => _SearchArticlesScreenState();
}

class _SearchArticlesScreenState extends State<SearchArticlesScreen> {
  final TextEditingController searchBarController = TextEditingController();
  Timer? _debounce;
  String _searchQuery = '';

  @override
  void dispose() {
    _debounce?.cancel();
    searchBarController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Prevent input longer than 50 chars.
    if (query.length > 50) {
      final truncatedQuery = query.substring(0, 50);
      // Setting the controller's value will trigger onChanged again with the truncated value.
      searchBarController.value = TextEditingValue(
        text: truncatedQuery,
        selection: TextSelection.collapsed(offset: truncatedQuery.length),
      );
      return; // Exit to avoid setting a timer for the non-truncated value.
    }

    // This setState is cheap and only rebuilds the AppBar to show/hide the clear button.
    if (mounted) setState(() {});

    // Debounce the actual search to avoid firing network requests on every keystroke.
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted && _searchQuery != query) {
        setState(() => _searchQuery = query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchBarController,
          autocorrect: false,
          style: TextStyle(
            fontSize: 20,
            color: appColors.appBarForegroundColor,
          ),
          keyboardType: TextInputType.text,
          cursorColor: appColors.appBarForegroundColor,
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(
              color: appColors.appBarForegroundColor?.withValues(alpha: 0.7),
            ),
            hintText: AppLocalizations.of(context)!.search,
          ),
          onChanged: _onSearchChanged,
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
                    if (mounted) setState(() {});
                  },
                  splashRadius: Constants.splashRadius,
                  icon: const Icon(Icons.close),
                  splashColor: Colors.transparent,
                )
              : const SizedBox(width: 20),
        ],
      ),
      body: _searchQuery.isEmpty ? null : ArticlesTab(mask: _searchQuery),
    );
  }
}
