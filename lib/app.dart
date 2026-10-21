import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'main_navigation_screen.dart';

class PhysicsCalcApp extends StatelessWidget {
  const PhysicsCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Physics Calc+',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MainNavigationScreen(),
    );
  }
}
