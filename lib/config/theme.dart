import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      scaffoldBackgroundColor: const Color(0xFFF8F8F8),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 14),
        titleLarge: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}