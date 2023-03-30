import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'firebase_options_dev.dart';
import 'my_app.dart';

Future<void> main() async {
  runApp(const MyApp());
  // Wait for the app to be properly initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}