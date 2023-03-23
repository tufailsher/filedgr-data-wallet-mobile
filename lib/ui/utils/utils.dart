/// Extension class that provides a function to capitalize a string.
extension StringExtension on String {
  /// Capitalizes the given string (i.e.: only the first letter will be in
  /// upper case, while the rest will be in lower case).
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}