/// Extension class that provides a function to capitalize a string.
extension StringExtension on String {
  /// Capitalizes the given string (i.e.: only the first letter will be in
  /// upper case, while the rest will be in lower case).
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  List<String> splitAfterLast(String delimiter) {
    final index = lastIndexOf(delimiter);
    if (index == -1) {
      return [this];
    } else if (index + delimiter.length < length) {
      return [substring(0, index), substring(index + delimiter.length, length)];
    } else {
      return [substring(0, index)];
    }
  }
}
