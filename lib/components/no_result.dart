import 'package:flutter/material.dart';

import '../utils/constants.dart' as constants;
import '../l10n/app_localizations.dart';

class NoResult extends StatelessWidget {
  const NoResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 180,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: constants.appColors.tileThemeColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off),
            Text("${AppLocalizations.of(context)!.noResult}!"),
          ],
        ),
      ),
    );
  }
}
