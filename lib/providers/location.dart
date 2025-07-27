import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../utils/storage.dart';

enum Location { none, ashgabat, arkadag, ahal, balkan, mary, dashoguz, lebap }

class LocationManager extends ChangeNotifier {
  Location _location = Location.none;

  Location get location => _location;

  Future<void> setLocation(Location location) async {
    if (_location == location) return;

    _location = location;
    notifyListeners();
    await Storage.instance.setLocation(_location);
  }

  static Location getLocationFromString(String location) {
    final locationMap = {
      'ashgabat': Location.none,
      'arkadag': Location.arkadag,
      'ahal': Location.ahal,
      'balkan': Location.balkan,
      'mary': Location.mary,
      'dashoguz': Location.dashoguz,
      'lebap': Location.lebap,
    };
    return locationMap[location] ?? Location.none;
  }

  static String getLocalizedLocation(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Location location = context.watch<LocationManager>().location;
    final locationMap = {
      Location.ashgabat: appLocalizations.ashgabat,
      Location.arkadag: appLocalizations.arkadag,
      Location.ahal: appLocalizations.ahal,
      Location.balkan: appLocalizations.balkan,
      Location.mary: appLocalizations.mary,
      Location.dashoguz: appLocalizations.dashoguz,
      Location.lebap: appLocalizations.lebap,
    };
    return locationMap[location] ?? appLocalizations.notSelected;
  }
}
