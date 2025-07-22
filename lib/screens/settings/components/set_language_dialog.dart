import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations_en.dart';
import '../../../l10n/app_localizations_ru.dart';
import '../../../l10n/app_localizations_tk.dart';
import '../../../l10n/app_localizations_tr.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/constants.dart' as constants;
import '../../../utils/locale.dart';
import 'language_option.dart';

Future<T?> showSetLanguageDialog<T>({
  required BuildContext context,
  Color? barrierColor,
  double blurSigmaX = constants.blurSigmaX,
  double blurSigmaY = constants.blurSigmaY,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor:
        barrierColor ?? Colors.black.withValues(alpha: constants.blurAlpha),
    builder: (BuildContext dialogContext) {
      final localeManager = Provider.of<LocaleManager>(context, listen: false);
      String selectedLocale = localeManager.locale!.languageCode;

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
                  style: TextStyle(color: constants.colorPrimary),
                ),
                onPressed: () {
                  constants.locale = Locale(selectedLocale);
                  localeManager.setLocale(constants.locale);
                  Navigator.of(context).pop();
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
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    },
  );
}
