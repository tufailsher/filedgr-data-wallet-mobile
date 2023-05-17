import 'package:shared_preferences/shared_preferences.dart';

/// Utility class used for providing a unique id for each notification the app
/// receives.
///
/// Thus, no notification will overwrite the previous one.
class NotificationId {
  static const _notificationIdKey = 'notification_id';
  static final _notificationId = NotificationId._internal();

  var _counter = 0;

  NotificationId._internal();

  factory NotificationId() => _notificationId;

  /// Returns the current [_counter] value and increments it by 1.
  int getId() => ++_counter;

  /// Saves the current [_counter] value locally using [SharedPreferences].
  Future<void> saveCurrentId() async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setInt(_notificationIdKey, _counter);
  }

  /// Loads the last saved notification id into the [_counter].
  Future<void> loadLastId() async {
    final sharedPref = await SharedPreferences.getInstance();
    _counter = sharedPref.getInt(_notificationIdKey) ?? 0;
  }
}
