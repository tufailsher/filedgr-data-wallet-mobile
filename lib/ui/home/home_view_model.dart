import 'package:flutter/foundation.dart';

/// The ViewModel for the Home screen.
class HomeViewModel with ChangeNotifier {
  bool _disposed = false;
  bool progressBarStatus = false;

  String contentText = '';

  /// Retrieves the data from the server.
  Future<void> getData() async {
    try {
      progressBarStatus = true;
      notifyListeners();

      // do request
      await Future.delayed(const Duration(seconds: 3), () {
        contentText = 'HOME: My awesome but simple text!';
      });
      // end request

    } on Exception catch (e) {
      debugPrint('Error: $e');
    } finally {
      progressBarStatus = false;
      notifyListeners();
    }
  }

  /// If this ChangeNotifier is disposed, then this call should do nothing.
  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  /// Disposes of the data.
  @override
  void dispose() {
    progressBarStatus = false;
    _disposed = true;
    super.dispose();
  }
}