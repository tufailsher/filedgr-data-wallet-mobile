import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A provider class that handles the retrieval and saving of the current
/// locale.
class LocaleProvider extends ChangeNotifier {
  Locale? locale;

  final supportedLocales = [
    SupportedLocale.english,
    SupportedLocale.german,
  ];

  SupportedLocale? get supportedLocale => locale?.toSupportedLocale();

  /// Retrieves the current locale code from the local SharedPreferences file
  /// and updates the class [locale] field.
  Future<void> getLocale() async {
    final sharedPref = await SharedPreferences.getInstance();
    final localeCode = sharedPref.getString('locale_code');
    if (localeCode == null) return;

    locale = Locale.fromSubtags(languageCode: localeCode);
    notifyListeners();
  }

  /// Saves the given [localeCode] in the local SharedPreferences file and
  /// updates the class [locale] field.
  Future<void> saveLocale(String language) async {
    final sharedPref = await SharedPreferences.getInstance();
    final sLocale = language.toSupportedLocale();
    if (sLocale == null) return;

    locale = Locale.fromSubtags(languageCode: sLocale.languageCode);
    sharedPref.setString('locale_code', sLocale.languageCode);
    notifyListeners();
  }
}

enum SupportedLocale {
  english("English", "en"),
  german("German", "de");

  const SupportedLocale(this.language, this.languageCode);

  final String language;
  final String languageCode;
}

/// Extension class that provides a function to retrieve the corresponding
/// [SupportedLocal] value for a given [Locale].
extension _Localextension on Locale {

  /// Returns the [SupportedLocal] value for the given [Locale], or null if
  /// none could be found.
  SupportedLocale? toSupportedLocale() {
    for (var element in SupportedLocale.values) {
      if (element.languageCode == languageCode) {
        return element;
      }
    }
    return null;
  }
}

/// Extension class that provides a function to retrieve the corresponding
/// [SupportedLocale] value for a given [String].
extension _StringExtension on String {

  /// Returns the [SupportedLocale] value for the given [String], or null if
  /// none could be found.
  SupportedLocale? toSupportedLocale() {
    for (var element in SupportedLocale.values) {
      if (element.name == this) {
        return element;
      }
    }
    return null;
  }
}