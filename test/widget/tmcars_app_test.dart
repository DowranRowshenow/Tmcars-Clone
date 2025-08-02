import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Project
import 'package:tmcarsclone/main.dart';
import 'package:tmcarsclone/models/article_category_model.dart';
import 'package:tmcarsclone/providers/locale.dart';
import 'package:tmcarsclone/providers/navigation.dart';
import 'package:tmcarsclone/providers/themes.dart';
import 'package:tmcarsclone/screens/menu/menu_screen.dart';
import 'package:tmcarsclone/utils/storage.dart';

void main() {
  // We will use the real providers for this test, as they are simple.
  late ThemeManager themeManager;
  late LocaleManager localeManager;

  // This setup function will be called before each test to ensure a clean state.
  setUp(() async {
    // Mock SharedPreferences and initialize Storage for each test.
    // Doing this in setUp ensures each test starts with a fresh, empty storage.
    // The testWidgets function automatically initializes the binding.
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await Storage.getInstance();

    themeManager = ThemeManager();
    localeManager = LocaleManager();
  });

  // A helper function to pump the widget with all necessary providers.
  // This avoids a lot of boilerplate in each test.
  Future<void> pumpTmcarsApp(WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: <SingleChildWidget>[
          // Use the instances created in setUp
          ChangeNotifierProvider<ThemeManager>.value(value: themeManager),
          ChangeNotifierProvider<LocaleManager>.value(value: localeManager),
          // For providers not under test, we can use real ones with default state.
          ChangeNotifierProvider<NavigationManager>(
            create: (_) => NavigationManager(),
          ),
          FutureProvider<List<ArticleCategory>>(
            create: (_) async =>
                <ArticleCategory>[], // Provide empty list for test
            initialData: const <ArticleCategory>[],
          ),
        ],
        child: const TmcarsApp(),
      ),
    );
  }

  group('TmcarsApp Widget Tests', () {
    testWidgets('renders MaterialApp with initial theme and locale', (
      WidgetTester tester,
    ) async {
      // Set initial state on providers
      themeManager.setThemeMode(ThemeMode.light);
      localeManager.setLocale('en');

      await pumpTmcarsApp(tester);

      // Find the MaterialApp widget
      final MaterialApp materialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );

      // Verify its properties
      expect(materialApp.themeMode, ThemeMode.light);
      expect(materialApp.locale, const Locale('en'));
      expect(find.byType(MenuScreen), findsOneWidget);
    });

    testWidgets('updates theme when ThemeManager notifies listeners', (
      WidgetTester tester,
    ) async {
      await pumpTmcarsApp(tester);

      // Verify initial theme is system
      MaterialApp materialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );
      expect(materialApp.themeMode, ThemeMode.system);

      // Change the theme in the provider and rebuild the widget tree
      themeManager.setThemeMode(ThemeMode.dark);
      await tester.pumpAndSettle();

      // Verify the theme has changed in MaterialApp
      materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.themeMode, ThemeMode.dark);
    });

    testWidgets('updates locale when LocaleManager notifies listeners', (
      WidgetTester tester,
    ) async {
      await pumpTmcarsApp(tester);

      // Verify initial locale is 'en'
      MaterialApp materialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );
      expect(materialApp.locale, const Locale('en'));

      // Change the locale in the provider and rebuild the widget tree
      localeManager.setLocale('tk');
      await tester.pumpAndSettle();

      // Verify the locale has changed in MaterialApp
      materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.locale, const Locale('tk'));
    });
  });
}
