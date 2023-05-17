import 'dart:async';
import 'dart:convert';

import 'package:file_dgr/core/notification/notification_id.dart';
import 'package:file_dgr/main.dart';
import 'package:file_dgr/ui/utils/app_strings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// The class that manages the push notifications. The app needs to request
/// and store a firebase token for sending it to the server in order to receive
/// push notifications.
class AppNotificationService {
  static final _notificationService = AppNotificationService._internal();

  AppNotificationService._internal();

  factory AppNotificationService() => _notificationService;

  final newNotification = StreamController<String>.broadcast();

  final _notificationId = NotificationId();
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const _channelId = 'com.filedgr.datawallet.temp.notification';

  /// Initializes the Firebase refresh token listener. When a new token is
  /// generated, the code inside this method will handle it.
  void initFirebaseTokenListener() {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
      debugPrint("Device token: $token");
    });
  }

  /// Initializes the notification click listener for both Android and iOS.
  /// The [onDidReceiveNotificationResponse] will be called whenever a new
  /// notification is received.
  ///
  /// The method also initializes the listener that intercepts notifications
  /// while the app is in background.
  Future<void> setup(
    Function(NotificationResponse) onDidReceiveNotificationResponse,
  ) async {
    // Load the last used notification id.
    await _notificationId.loadLastId();
    // Setup Firebase Messaging
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Check if app was opened from a notification
    final notificationAppLaunchDetails =
        await _localNotificationsPlugin.getNotificationAppLaunchDetails();
    final notificationResponse =
        notificationAppLaunchDetails?.notificationResponse;
    if (notificationResponse != null) {
      onDidReceiveNotificationResponse(notificationResponse);
    }

    // Setup Flutter Local Notifications
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  /// Parses the given [message] and returns the data.
  Map<String, dynamic> _parseNotification(RemoteMessage message) {
    final data = message.data;
    final pData = <String, dynamic>{};
    data.forEach((key, value) {
      try {
        pData[key] = jsonDecode(value ?? '');
      } on Exception {
        pData[key] = value;
      }
    });
    return pData;
  }

  /// Initializes the listener that intercepts notifications while the app is
  /// in foreground. If the MainScreen widget is in foreground, then the
  /// notification will be added to [newNotification]. Otherwise, the
  /// [_showNotification] will be called.
  ///
  /// If the app doesn't have permissions for showing notifications, it
  /// requests them.
  Future<void> listenFCM() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;

    FirebaseMessaging.onMessage.listen((message) {
      debugPrint(
        'Got a message whilst in the foreground! Message data: ${message.data}',
      );
      final data = _parseNotification(message);

      if (MyApp.isInMainScreen) {
        newNotification.add(jsonEncode(data));
      } else {
        _showNotification(data);
      }
    });
    /*FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint(
        'Got a message whilst in the background! Message data: ${message.data}',
      );
    });*/
  }

  /// Displays a notification for the given [data] for both Android and iOS.
  void _showNotification(Map<String, dynamic> data) {
    final messageBody = data['message'] ?? '';
    final notificationId = _notificationId.getId();
    _notificationId.saveCurrentId();

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      AppStrings.channelNotification,
      channelDescription: AppStrings.channelNotificationDescription,
      importance: Importance.high,
      priority: Priority.defaultPriority,
      autoCancel: true,
      timeoutAfter: 60 * 1000,
    );
    const iosDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    _localNotificationsPlugin.show(
      notificationId,
      AppStrings.appName,
      messageBody,
      notificationDetails,
      payload: jsonEncode(data),
    );
  }
}

/// Handler that intercepts notifications while the app is in background and
/// calls [_showNotification] with the retrieved data from the given [message].
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.data}');
  final data = AppNotificationService()._parseNotification(message);
  AppNotificationService()._showNotification(data);
}
