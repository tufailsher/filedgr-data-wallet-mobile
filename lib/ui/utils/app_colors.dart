import 'package:flutter/material.dart';

/// The class that contains all the custom colors the app uses.
class AppColors {
  static const darkBlue = Color(0xFF000A33);
  static const darkBlue500 = Color(0xFF193266);

  static const turquoise = Color(0xFF00ADA7);
}

/// Extension class that provides a function to transform a Color to a
/// MaterialColor.
extension ColorExtension on Color {
  /// Returns the MaterialColor equivalent to the given Color.
  MaterialColor toMaterial() => _getMaterialColor(this);
}

MaterialColor _getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };
  return MaterialColor(color.value, shades);
}
