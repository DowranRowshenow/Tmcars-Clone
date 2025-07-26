import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/constants.dart';
import '../../../providers/locale.dart';
import '../../../providers/themes.dart';

Future<T?> showSetLanguageDialog<T>({
  required BuildContext context,
  Color? barrierColor,
  double blurSigmaX = Constants.blurSigmaX,
  double blurSigmaY = Constants.blurSigmaY,
  bool barrierDismissible = true,
}) {
  // A map to hold the native names for each supported language.
  // This is much cleaner than creating instances of AppLocalizations.
  const languageNames = <String, String>{
    'en': 'English',
    'ru': 'Русский',
    'tk': 'Türkmen',
    'tr': 'Türkçe',
  };
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor:
        barrierColor ?? Colors.black.withValues(alpha: Constants.blurAlpha),
    builder: (BuildContext dialogContext) {
      final localeManager = context.watch<LocaleManager>();
      String selectedLanguageCode = localeManager.locale.languageCode;
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(Constants.dialogPadding),
            contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            backgroundColor: appColors.themedSurface,
            elevation: Constants.elevation,
            title: Text(
              AppLocalizations.of(context)!.selectLanguage,
              style: TextStyle(color: appColors.textThemeColor),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                // Generate the list dynamically from supported locales.
                children: AppLocalizations.supportedLocales.map((locale) {
                  final langCode = locale.languageCode;
                  return RadioListTile<bool>(
                    title: Text(languageNames[langCode] ?? langCode),
                    value: true,
                    groupValue: selectedLanguageCode == langCode,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedLanguageCode = langCode;
                      });
                    },
                    activeColor: Constants.colorPrimary,
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: InkSparkle.splashFactory,
                ),
                child: Text(
                  AppLocalizations.of(context)!.select,
                  style: const TextStyle(color: Constants.colorPrimary),
                ),
                onPressed: () {
                  // Use context.read inside a callback.
                  // Set the new locale and pop the dialog.
                  context.read<LocaleManager>().setLocale(selectedLanguageCode);
                  Navigator.of(dialogContext).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: InkSparkle.splashFactory,
                ),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: const TextStyle(color: Constants.colorPrimary),
                ),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
            ],
          );
        },
      );
    },
  );
}
