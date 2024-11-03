import 'package:flutter/material.dart';
import 'package:task_mate/core/utils/colors.dart';
import 'package:task_mate/features/auth/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Task-Mate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
        textTheme: _textTheme,
        inputDecorationTheme: _inputDecorationTheme,
        elevatedButtonTheme: _elevatedButtonThemeData,
      ),
      home: const SplashScreen(),
    );
  }

  final TextTheme _textTheme = const TextTheme(
    displayLarge: TextStyle(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      color: Colors.black,
      fontSize: 12,
    ),
    labelLarge: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: Colors.black,
      fontSize: 10,
      fontWeight: FontWeight.w400,
    ),
  );

  static const OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
    borderSide: BorderSide(width: 2, color: Colors.grey),
  );

  static const OutlineInputBorder _outlineErrorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
    borderSide: BorderSide(width: 2, color: Colors.red),
  );

  static final OutlineInputBorder _outlineDisableInputBorder = OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      Radius.circular(8.0),
    ),
    borderSide: BorderSide(width: 2, color: Colors.grey.withOpacity(0.4)),
  );

  final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: _outlineInputBorder,
    focusedBorder: _outlineInputBorder,
    enabledBorder: _outlineInputBorder,
    disabledBorder: _outlineDisableInputBorder,
    errorBorder: _outlineErrorInputBorder,
    hintStyle: const TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w500,
    ),
  );

  final ElevatedButtonThemeData _elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.w500)
    ),
  );
}
