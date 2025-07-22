import 'package:flutter/material.dart';

import 'storage.dart';

class LocationManager extends ChangeNotifier {
  // Provide a default locale to ensure _locale is never null.
  // The actual initial locale will be set from main.dart at startup.
  String _location = '';

  String get location => _location;

  Future<void> setLocation(String location) async {
    if (_location == location) return;

    _location = location;
    notifyListeners();
    // Save to SharedPreferences asynchronously
    await Storage().setLocale(_location);
  }
}
