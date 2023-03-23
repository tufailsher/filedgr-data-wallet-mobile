import 'package:file_dgr/ui/utils/theme_provider.dart';
import 'package:file_dgr/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  test('Theme Mode updates successfully', () async {
    final themeProvider = ThemeProvider();
    expect(themeProvider.themeMode, ThemeMode.system);

    // Change the theme to light
    await themeProvider.saveTheme('light');
    expect(themeProvider.themeMode, ThemeMode.light);

    // Change the theme to dark
    await themeProvider.saveTheme('dark');
    expect(themeProvider.themeMode, ThemeMode.dark);

    // Change the theme to some other string
    await themeProvider.saveTheme('my-other-string');
    expect(themeProvider.themeMode, ThemeMode.dark);
  });

  test('String\'s capitalize retrieves the right value', () {
    const expected = 'Lorem ipsum dolor';

    expect('LOREM IPSUM DOLOR'.capitalize(), expected);
    expect('lorem ipsum dolor'.capitalize(), expected);
    expect('lORem IpSum doLor'.capitalize(), expected);
  });
}
