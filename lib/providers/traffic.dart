import 'package:flutter/material.dart';

import '../utils/storage.dart';

class TrafficManager extends ChangeNotifier {
  int _trafficMode = 0;

  int get getTrafficMode => _trafficMode;

  Future<void> setTrafficMode(int mode) async {
    if (mode == _trafficMode) {
      return; // Avoid unnecessary notifications and saves
    }

    _trafficMode = mode;
    notifyListeners();
    await Storage.instance.setTrafficMode(_trafficMode);
  }

  bool isStandart() {
    return _trafficMode == 0;
  }
}
