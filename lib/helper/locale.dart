import 'package:flutter/material.dart';

import 'storage.dart';

class LocaleManager extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    // Save to SharedPreferences asynchronously
    Storage().setLocale(locale);
  }
}
