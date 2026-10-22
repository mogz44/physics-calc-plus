import 'package:flutter/material.dart';
import 'app.dart';
import 'core/settings/app_settings_controller.dart';
import 'core/settings/app_settings_scope.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = AppSettingsController();
  await settingsController.loadSettings();

  runApp(
    AppSettingsScope(
      controller: settingsController,
      child: PhysicsCalcApp(settingsController: settingsController),
    ),
  );
}
