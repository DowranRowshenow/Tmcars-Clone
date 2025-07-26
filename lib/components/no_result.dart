import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../providers/themes.dart';

class NoResult extends StatelessWidget {
  const NoResult({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Center(
      child: Container(
        width: 180,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: appColors.tileThemeColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off),
            Text("${AppLocalizations.of(context)!.noResult}!"),
          ],
        ),
      ),
    );
  }
}
