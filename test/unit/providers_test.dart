import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Project
import 'package:tmcarsclone/providers/locale.dart';
import 'package:tmcarsclone/providers/location.dart';
import 'package:tmcarsclone/providers/themes.dart';
import 'package:tmcarsclone/providers/traffic.dart';
import 'package:tmcarsclone/utils/storage.dart';

// A helper class to verify that `notifyListeners` is called.
class MockListener {
  int callCount = 0;
  void call() {
    callCount++;
  }
}

void main() {
  // This is required to mock platform channels for SharedPreferences in unit tests.
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Mock SharedPreferences and initialize the Storage singleton for all tests.
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await Storage.getInstance();
  });

  group('Provider Unit Tests', () {
    group('ThemeManager', () {
      test('setThemeMode updates the theme and notifies listeners', () {
        final ThemeManager themeManager = ThemeManager();
        final MockListener listener = MockListener();
        themeManager.addListener(listener.call);

        // Check initial state
        expect(themeManager.themeMode, ThemeMode.system);

        // Change theme
        themeManager.setThemeMode(ThemeMode.dark);

        // Check new state and that listener was called
        expect(themeManager.themeMode, ThemeMode.dark);
        expect(listener.callCount, 1);

        // Clean up
        themeManager.removeListener(listener.call);
      });
    });

    group('LocaleManager', () {
      test('setLocale updates the locale and notifies listeners', () {
        final LocaleManager localeManager = LocaleManager();
        final MockListener listener = MockListener();
        localeManager.addListener(listener.call);

        // Check initial state (defaults to 'en')
        expect(localeManager.locale, const Locale('en'));

        // Change locale
        localeManager.setLocale('tk');

        // Check new state and that listener was called
        expect(localeManager.locale, const Locale('tk'));
        expect(listener.callCount, 1);

        // Clean up
        localeManager.removeListener(listener.call);
      });
    });

    group('TrafficManager', () {
      test('setTrafficMode updates the mode and notifies listeners', () {
        final TrafficManager trafficManager = TrafficManager();
        final MockListener listener = MockListener();
        trafficManager.addListener(listener.call);

        // Check initial state (defaults to 0)
        expect(trafficManager.trafficMode, 0);

        // Change mode
        trafficManager.setTrafficMode(1);

        // Check new state and that listener was called
        expect(trafficManager.trafficMode, 1);
        expect(listener.callCount, 1);

        // Clean up
        trafficManager.removeListener(listener.call);
      });
    });

    group('LocationManager', () {
      test('setLocation updates the location and notifies listeners', () {
        final LocationManager locationManager = LocationManager();
        final MockListener listener = MockListener();
        locationManager.addListener(listener.call);

        const Location newLocation = Location.ahal;
        locationManager.setLocation(newLocation);

        expect(locationManager.location, newLocation);
        expect(listener.callCount, 1);

        locationManager.removeListener(listener.call);
      });
    });
  });
}
