import 'package:flutter/material.dart';

import 'storage.dart';

class LocaleManager extends ChangeNotifier {
  // Provide a default locale to ensure _locale is never null.
  // The actual initial locale will be set from main.dart at startup.
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> setLocale(String localeCode) async {
    if (_locale == locale) return; // Avoid unnecessary notifications and saves

    _locale = Locale(localeCode);
    notifyListeners();
    // Save to SharedPreferences asynchronously
    await Storage().setLocale(localeCode);
  }
}
