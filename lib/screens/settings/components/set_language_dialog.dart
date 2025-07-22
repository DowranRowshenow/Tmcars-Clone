import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/constants.dart' as constants;
import '../../../utils/locale.dart';

Future<T?> showSetLanguageDialog<T>({
  required BuildContext context,
  Color? barrierColor,
  double blurSigmaX = constants.blurSigmaX,
  double blurSigmaY = constants.blurSigmaY,
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
        barrierColor ?? Colors.black.withValues(alpha: constants.blurAlpha),
    builder: (BuildContext dialogContext) {
      final localeManager = context.watch<LocaleManager>();
      String selectedLanguageCode = localeManager.locale.languageCode;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(constants.dialogPadding),
            contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            backgroundColor: constants.appColors.themedSurface,
            elevation: constants.elevation,
            title: Text(
              AppLocalizations.of(context)!.selectLanguage,
              style: TextStyle(color: constants.appColors.textThemeColor),
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
                    activeColor: constants.colorPrimary,
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
                  style: TextStyle(color: constants.colorPrimary),
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
                  style: TextStyle(color: constants.colorPrimary),
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
