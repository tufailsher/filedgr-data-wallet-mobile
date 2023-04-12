import 'dart:convert';

import 'package:file_dgr/core/responses/hello_response.dart';
import 'package:file_dgr/ui/utils/flavor_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// The ViewModel for the Home screen.
class HomeViewModel with ChangeNotifier {
  bool _disposed = false;
  bool progressBarStatus = false;

  String contentText = '';

  late FlavorSettings _flavorSettings;

  /// Retrieves the data from the server.
  Future<void> getData() async {
    try {
      _flavorSettings = await FlavorSettings.getSettings();
      progressBarStatus = true;
      notifyListeners();

      // do request
      final response = await http.get(
        Uri.parse('${_flavorSettings.baseUrl}/mock/hello'),
      );
      final json = jsonDecode(response.body);
      final helloResponse = HelloResponse.fromJson(json);
      contentText = helloResponse.name;
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
