import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations_en.dart';
import '../l10n/app_localizations_ru.dart';
import '../l10n/app_localizations_tk.dart';
import '../l10n/app_localizations_tr.dart';
import '../l10n/app_localizations.dart';
import '../helper/constants.dart';
import '../helper/locale.dart';
import 'language_option.dart';

Future<T?> showSelectLanguageDialog<T>({
  required BuildContext context,
  Color? barrierColor,
  double blurSigmaX = blurSigmaX,
  double blurSigmaY = blurSigmaY,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor ?? Colors.black.withValues(alpha: blurAlpha),
    builder: (BuildContext dialogContext) {
      final localeManager = Provider.of<LocaleManager>(context, listen: false);
      String selectedLocale = localeManager.locale!.languageCode;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            backgroundColor: appColors.themedSurface,
            elevation: elevation,
            title: Text(
              AppLocalizations.of(context)!.selectLanguage,
              style: TextStyle(color: appColors.textThemeColor),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  LanguageOption(
                    appLocalizations: AppLocalizationsEn(),
                    isSelected: selectedLocale == 'en',
                    onTap: () {
                      setState(() {
                        selectedLocale = 'en';
                      });
                    },
                  ),
                  LanguageOption(
                    appLocalizations: AppLocalizationsRu(),
                    isSelected: selectedLocale == 'ru',
                    onTap: () {
                      setState(() {
                        selectedLocale = 'ru';
                      });
                    },
                  ),
                  LanguageOption(
                    appLocalizations: AppLocalizationsTk(),
                    isSelected: selectedLocale == 'tk',
                    onTap: () {
                      setState(() {
                        selectedLocale = 'tk';
                      });
                    },
                  ),
                  LanguageOption(
                    appLocalizations: AppLocalizationsTr(),
                    isSelected: selectedLocale == 'tr',
                    onTap: () {
                      setState(() {
                        selectedLocale = 'tr';
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: InkSparkle.splashFactory,
                ),
                child: Text(
                  AppLocalizations.of(context)!.select,
                  style: TextStyle(color: colorPrimary),
                ),
                onPressed: () {
                  localeManager.setLocale(Locale(selectedLocale));
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: InkSparkle.splashFactory,
                ),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: TextStyle(color: colorPrimary),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    },
  );
}
