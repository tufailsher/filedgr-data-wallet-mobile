import 'package:file_dgr/ui/main/main_screen.dart';
import 'package:file_dgr/ui/utils/app_colors.dart';
import 'package:file_dgr/ui/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _themeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    _themeProvider.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _themeProvider,
      builder: (context, _) => Consumer<ThemeProvider>(
        builder: (_, __, ___) => MaterialApp(
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
          home: MainScreen(
            themeProvider: _themeProvider,
          ),
        ),
      ),
    );
  }
}
