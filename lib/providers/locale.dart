import 'package:flutter/material.dart';

import '../l10n/app_localizations_en.dart';
import '../l10n/app_localizations_ru.dart';
import '../l10n/app_localizations_tk.dart';
import '../l10n/app_localizations_tr.dart';
import '../utils/storage.dart';

class LocaleManager extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> setLocale(String localeCode) async {
    if (_locale.languageCode == localeCode) return;

    _locale = Locale(localeCode);
    notifyListeners();
    await Storage.instance.setLocale(localeCode);
  }

  static String getCurrentLocaleLanguage(String code) {
    final Map<String, String> map = {
      'en': AppLocalizationsEn().lang,
      'ru': AppLocalizationsRu().lang,
      'tk': AppLocalizationsTk().lang,
      'tr': AppLocalizationsTr().lang,
    };
    return map[code] ?? "";
  }
}
