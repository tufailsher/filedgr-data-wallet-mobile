import 'dart:convert';

import 'package:file_dgr/core/notification/app_notification_service.dart';
import 'package:file_dgr/ui/main/main_screen.dart';
import 'package:file_dgr/ui/utils/app_colors.dart';
import 'package:file_dgr/ui/utils/locale_provider.dart';
import 'package:file_dgr/ui/utils/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

Future<void> main() async {
  // Wait for the app to be properly initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the firebase app
  await Firebase.initializeApp();

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(const MyApp());
}

/// The main app widget.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();
  static var isInMainScreen = false;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _themeProvider = ThemeProvider();
  final _localeProvider = LocaleProvider();

  /// The route configuration.
  late final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return MainScreen(
            themeProvider: _themeProvider,
            localeProvider: _localeProvider,
            screenName: MenuOption.home,
          );
        },
        routes: const <RouteBase>[
        ],
      ),
      GoRoute(
        path: '/about',
        builder: (BuildContext context, GoRouterState state) {
          return MainScreen(
            themeProvider: _themeProvider,
            localeProvider: _localeProvider,
            screenName: MenuOption.about,
          );
        },
      ),
    ],
  );

  /// If the [notificationResponse] contains some data, then the
  /// MainScreen is opened with the given data.
  Future<void> _onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    // final context = MyApp.navigatorKey.currentContext;
    // if (context == null) return;

    final data = notificationResponse.payload;
    if (data == null) return;

    final obj = jsonDecode(data);
    final screenName =
        obj["screen_name"] == "home" ? "/" : "/${obj["screen_name"]}";

    _router.go(screenName);

    /* await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => MainScreen(
          themeProvider: _themeProvider,
          localeProvider: _localeProvider,
          notificationData: data,
        ), // pass in the data
      ),
      (route) => false,
    );*/
  }

  /// Initializes the Firebase Messaging service, along with the device token
  /// refresh listener.
  Future<void> _initFCM() async {
    WidgetsFlutterBinding.ensureInitialized();
    // If you're going to use other Firebase services in the background, such as
    // Firestore, make sure you call `initializeApp` before using other Firebase
    // services.
    AppNotificationService().initFirebaseTokenListener();
    await AppNotificationService().setup(_onDidReceiveNotificationResponse);
    await AppNotificationService().listenFCM();
  }

  /// Checks if there are messages that opened the app from a terminated state
  /// and handles them.
  ///
  /// The method is not needed using the current implementation. This relies on
  /// an another type of flow.
  /*Future<void> _setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }*/

  /// Handles a notification message detected by [_setupInteractedMessage].
  ///
  /// The method is not needed using the current implementation. This relies on
  /// an another type of flow.
  /*void _handleMessage(RemoteMessage message) {
    debugPrint('message: ---- ${message.data}');
  }*/

  /// Initializes the state and retrieves the current app's theme.
  @override
  void initState() {
    super.initState();
    _initFCM();
    _themeProvider.getTheme();
    _localeProvider.getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _themeProvider),
        ChangeNotifierProvider.value(value: _localeProvider)
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (_, __, ___, ____) => MaterialApp.router(
          routerConfig: _router,
          // navigatorKey: MyApp.navigatorKey,
          locale: _localeProvider.locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: 'FileDGR',
          theme: ThemeData(
            // This is the theme of your application.
            brightness: Brightness.light,
            // primarySwatch: AppColors.turquoise.toMaterial(),
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: AppColors.turquoise.toMaterial(),
            ).copyWith(
              primary: AppColors.darkBlue,
              primaryContainer: Colors.grey,
            ),
            fontFamily: 'ProximaNova',
          ),
          darkTheme: ThemeData(
            // This is the dark theme of your application.
            brightness: Brightness.dark,
            colorScheme: ThemeData.dark().colorScheme.copyWith(
                  primary: AppColors.turquoise,
                  primaryContainer: AppColors.darkBlue500,
                  surface: AppColors.darkBlue500,
                ),
            canvasColor: AppColors.darkBlue,
            scaffoldBackgroundColor: AppColors.darkBlue,
            fontFamily: 'ProximaNova',
          ),
          themeMode: _themeProvider.themeMode,
          /*home: MainScreen(
            themeProvider: _themeProvider,
            localeProvider: _localeProvider,
          ),*/
        ),
      ),
    );
  }
}
