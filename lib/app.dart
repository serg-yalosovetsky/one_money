import 'package:flutter/material.dart';
import 'navigation/main_navigation.dart';
import 'config/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1Money Clone',
      theme: AppTheme.lightTheme,
      home: const MainNavigation(),
    );
  }
}
