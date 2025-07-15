import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmcarsclone/l10n/app_localizations_en.dart';
import 'package:tmcarsclone/l10n/app_localizations_ru.dart';
import 'package:tmcarsclone/l10n/app_localizations_tk.dart';
import 'package:tmcarsclone/l10n/app_localizations_tr.dart';

import '../helper/constants.dart';
import '../helper/locale.dart';
import '../l10n/app_localizations.dart';
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
      Locale? selectedLocale = localeManager.locale;

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
                    isSelected: selectedLocale?.languageCode == 'en',
                    onTap: () {
                      setState(() {
                        selectedLocale = const Locale('en');
                      });
                    },
                  ),
                  LanguageOption(
                    appLocalizations: AppLocalizationsRu(),
                    isSelected: selectedLocale?.languageCode == 'ru',
                    onTap: () {
                      setState(() {
                        selectedLocale = const Locale('ru');
                      });
                    },
                  ),
                  LanguageOption(
                    appLocalizations: AppLocalizationsTk(),
                    isSelected: selectedLocale?.languageCode == 'tk',
                    onTap: () {
                      setState(() {
                        selectedLocale = const Locale('tk');
                      });
                    },
                  ),
                  LanguageOption(
                    appLocalizations: AppLocalizationsTr(),
                    isSelected: selectedLocale?.languageCode == 'tr',
                    onTap: () {
                      setState(() {
                        selectedLocale = const Locale('tr');
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
                  if (selectedLocale != null) {
                    localeManager.setLocale(selectedLocale!);
                  }
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
