import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'core/settings/app_settings_controller.dart';
import 'core/settings/app_settings_scope.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = AppSettingsController();
  await settingsController.loadSettings();

  final prefs = await SharedPreferences.getInstance();
  final isFirstRun = prefs.getBool('is_first_run') ?? true;

  runApp(
    AppSettingsScope(
      controller: settingsController,
      child: PhysicsCalcApp(
        settingsController: settingsController,
        isFirstRun: isFirstRun,
      ),
    ),
  );
}
