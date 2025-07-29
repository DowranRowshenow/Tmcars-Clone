import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/constants.dart';
import '../../../providers/locale.dart';
import '../../../providers/themes.dart';

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
      final LocaleManager localeManager = context.watch<LocaleManager>();
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;
      final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
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
          width: double.maxFinite,
          child: StatefulBuilder(
            builder: (context, setState) {
              return ListView(
                shrinkWrap: true,
                children: AppLocalizations.supportedLocales.map((locale) {
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
        actions: [
          TextButton(
            child: Text(
              appLocalizations.select,
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () {
              context.read<LocaleManager>().setLocale(selectedLanguageCode);
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
