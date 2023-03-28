/// Extension class that provides various functions on Strings.
extension StringExtension on String {
  /// Capitalizes the given string (i.e.: only the first letter will be in
  /// upper case, while the rest will be in lower case).
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Splits the string by the given [delimiter] and returns the list of splits.
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
