import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A provider class that handles the retrieval and saving of the current theme
/// mode.
class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  /// Retrieves the current theme mode from the local SharedPreferences file and
  /// updates the class [themeMode] field.
  Future<void> getTheme() async {
    final sharedPref = await SharedPreferences.getInstance();
    final cThemeMode = sharedPref.getString('theme_mode');
    final newThemeMode = cThemeMode?.toThemeMode();
    if (newThemeMode == null) return;

    themeMode = newThemeMode;
    notifyListeners();
  }

  /// Saves the given [themeMode] in the local SharedPreferences file and
  /// updates the class *themeMode* field.
  Future<void> saveTheme(String themeMode) async {
    final sharedPref = await SharedPreferences.getInstance();
    final newThemeMode = themeMode.toThemeMode();
    if (newThemeMode == null) return;

    this.themeMode =  newThemeMode;
    sharedPref.setString('theme_mode', this.themeMode.name);
    notifyListeners();
  }
}

/// Extension class that provides a function to retrieve the corresponding
/// [ThemeMode] value for a given [String].
extension _ThemeModeExtension on String {

  /// Returns the [ThemeMode] value for the given [String], or null if none
  /// could be found.
  ThemeMode? toThemeMode() {
    for (var element in ThemeMode.values) {
      if (element.name == this) {
        return element;
      }
    }
    return null;
  }
}