import 'package:flutter/material.dart';

import '../utils/storage.dart';

class TrafficManager extends ChangeNotifier {
  // Provide a default locale to ensure _locale is never null.
  // The actual initial locale will be set from main.dart at startup.
  int _trafficMode = 0;

  int get getTrafficMode => _trafficMode;

  Future<void> setTrafficMode(int mode) async {
    if (mode == _trafficMode) {
      return; // Avoid unnecessary notifications and saves
    }

    _trafficMode = mode;
    notifyListeners();
    // Save to SharedPreferences asynchronously
    await Storage.instance.setTrafficMode(_trafficMode);
  }
}
