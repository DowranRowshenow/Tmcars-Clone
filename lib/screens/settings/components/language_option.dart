import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../helper/constants.dart';

class LanguageOption extends StatelessWidget {
  final AppLocalizations appLocalizations;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOption({
    super.key,
    required this.appLocalizations,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 0,
      horizontalTitleGap: 0,
      title: Text(
        appLocalizations.lang,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: appColors.textThemeColor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        appLocalizations.langEn,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: appColors.textThemeColor?.withValues(alpha: 0.7),
        ),
      ),
      leading: Radio<Locale>(
        value: Locale(appLocalizations.locale),
        groupValue: isSelected ? Locale(appLocalizations.locale) : null,
        onChanged: (Locale? value) {
          onTap();
        },
        activeColor: colorPrimary,
      ),
      onTap: onTap,
    );
  }
}
