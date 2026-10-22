import 'package:flutter/material.dart';
import 'app_settings_controller.dart';

/// AppSettingsController'ı widget ağacına sağlayan InheritedNotifier.
class AppSettingsScope extends InheritedNotifier<AppSettingsController> {
  const AppSettingsScope({
    super.key,
    required AppSettingsController controller,
    required super.child,
  }) : super(notifier: controller);

  static AppSettingsController of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppSettingsScope>();
    assert(scope != null, 'AppSettingsScope widget ağacında bulunamadı!');
    return scope!.notifier!;
  }
}
