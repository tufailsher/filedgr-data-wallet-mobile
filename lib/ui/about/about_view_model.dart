import 'package:flutter/foundation.dart';

class AboutViewModel with ChangeNotifier {
  bool _disposed = false;
  bool progressBarStatus = false;

  String contentText = '';

  Future<void> getData() async {
    try {
      progressBarStatus = true;
      notifyListeners();

      // do request
      await Future.delayed(const Duration(seconds: 3), () {
        contentText = 'ABOUT: My awesome but simple text!';
      });
      // end request

    } on Exception catch (e) {
      // log exception
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

  @override
  void dispose() {
    progressBarStatus = false;
    _disposed = true;
    super.dispose();
  }
}