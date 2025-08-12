import 'package:flutter/material.dart';
import 'package:tmcarsclone/components/minimal_button.dart';
import 'package:tmcarsclone/components/search_dialog.dart';

import '../l10n/app_localizations.dart';
import '../models/car_query_model.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';

class SearchProductBar extends StatelessWidget {
  const SearchProductBar({
    super.key,
    required this.searchBarController,
    required this.query,
    this.onTap,
  });
  final GestureTapCallback? onTap;
  final ValueNotifier<CarQuery> query;
  final TextEditingController searchBarController;
  static const double height = 45;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            onTap: onTap,
            readOnly: onTap == null ? true : false,
            controller: searchBarController,
            autocorrect: false,
            style: const TextStyle(fontSize: 16),
            keyboardType: TextInputType.text,
            decoration: InputDecoration.collapsed(
              hintText: Localizations.of<AppLocalizations>(
                context,
                AppLocalizations,
              )!.search,
            ),
          ),
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: searchBarController,
          builder:
              (BuildContext context, TextEditingValue value, Widget? child) {
                if (value.text.isNotEmpty) {
                  return IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    splashRadius: Constants.splashRadius,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      searchBarController.text = "";
                      query.value = CarQuery();
                    },
                  );
                }
                return IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(
                      context,
                    ).extension<AppColors>()!.iconThemeColor,
                  ),
                  splashRadius: Constants.splashRadius,
                  splashColor: Colors.transparent,
                  onPressed: onTap,
                );
              },
        ),
        GestureDetector(
          onTap: () {},
          child: const MinimalButton(text: "~"),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            searchDialog(context: context);
          },
          child: const MinimalButton(text: "?"),
        ),
      ],
    );
  }
}
