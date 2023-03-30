import 'package:file_dgr/my_app.dart';
import 'package:file_dgr/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Tapping on the Theme Switcher changes the theme',
      (tester) async {
    await tester.pumpWidget(const MyApp());
    final BuildContext context = tester.element(find.byType(AppBar));

    // Tap on the menu button to open the menu
    final menuButton = find.byIcon(Icons.menu);
    await tester.tap(menuButton);
    await tester.pumpAndSettle();

    // Check that the default theme is the 'System' theme
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    expect(Theme.of(context).brightness == brightness, true);

    // Tap on the theme switcher dropdown, which by default should have the
    // 'System' option selected
    var dropdown = find.text(ThemeMode.system.name.capitalize());
    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    // Tap on the 'Light' option
    final dropdownItemLight = find.text(ThemeMode.light.name.capitalize()).last;
    await tester.tap(dropdownItemLight);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Check that the app's theme is now the 'Dark' one
    expect(Theme.of(context).brightness == Brightness.dark, false);

    // Tap on the theme switcher dropdown, which should now have the 'Light'
    // option selected
    dropdown = find.text(ThemeMode.light.name.capitalize());
    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    // Tap on the 'Dark' option
    final dropdownItemDark = find.text(ThemeMode.dark.name.capitalize()).last;
    await tester.tap(dropdownItemDark);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Check that the app's theme is now the 'Light' one
    expect(Theme.of(context).brightness == Brightness.dark, true);
  });
}
