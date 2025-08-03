import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/locale.dart';
import '../../../providers/themes.dart';
import '../../../utils/constants.dart';

Future<bool?> showSetLanguageDialog({
  required BuildContext context,
  Color? barrierColor,
  bool barrierDismissible = true,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor:
        barrierColor ?? Colors.black.withValues(alpha: Constants.blurAlpha),
    builder: (BuildContext dialogContext) {
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;
      final AppLocalizations appLocalizations =
          Localizations.of<AppLocalizations>(context, AppLocalizations)!;
      final LocaleManager localeManager = context.read<LocaleManager>();
      String selectedLanguageCode = localeManager.locale.languageCode;

      return AlertDialog(
        insetPadding: const EdgeInsets.all(Constants.dialogPadding),
        contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        backgroundColor: appColors.themedSurface,
        elevation: Constants.elevation,
        title: Text(
          appLocalizations.selectLanguage,
          style: TextStyle(color: appColors.textThemeColor),
        ),
        content: SizedBox(
          width: Constants.dialogWidth,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return ListView(
                shrinkWrap: true,
                children: AppLocalizations.supportedLocales.map((
                  Locale locale,
                ) {
                  return RadioListTile<bool>(
                    title: Text(
                      LocaleManager.getCurrentLocaleLanguage(
                        locale.languageCode,
                      ),
                    ),
                    value: true,
                    groupValue: selectedLanguageCode == locale.languageCode,
                    onChanged: (bool? value) {
                      if (context.mounted) {
                        setState(() {
                          selectedLanguageCode = locale.languageCode;
                        });
                      }
                    },
                    activeColor: Constants.colorPrimary,
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                }).toList(),
              );
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              appLocalizations.select,
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () {
              localeManager.setLocale(selectedLanguageCode);
              Navigator.of(dialogContext).pop();
            },
          ),
          TextButton(
            child: Text(
              appLocalizations.cancel,
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
        ],
      );
    },
  );
}
