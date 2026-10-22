import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:physics_calc/app.dart';
import 'package:physics_calc/core/settings/app_settings_controller.dart';
import 'package:physics_calc/core/settings/app_settings_scope.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Physics Calc+ render smoke test (Türkçe)', (WidgetTester tester) async {
    final controller = AppSettingsController();
    await controller.loadSettings();
    await controller.setLocale(const Locale('tr'));

    await tester.pumpWidget(
      AppSettingsScope(
        controller: controller,
        child: PhysicsCalcApp(settingsController: controller),
      ),
    );
    await tester.pumpAndSettle();

    // Verify AppBar title exists
    expect(find.text('Physics Calc+'), findsOneWidget);

    // Verify 3 bottom navigation tabs exist in Turkish
    expect(find.text('Hesaplayıcı'), findsOneWidget);
    expect(find.text('Dönüştürücü'), findsOneWidget);
    expect(find.text('Ayarlar'), findsOneWidget);

    // Verify default 2 input rows exist with stacked design placeholders
    expect(find.text('Fiziksel Büyüklük Seç'), findsNWidgets(2));
    expect(find.text('Değer Ekle'), findsOneWidget);
    expect(find.text('Sonuç Raporunu Gör'), findsOneWidget);
  });

  testWidgets('Physics Calc+ Dil Değişimi Testi (English switch)', (WidgetTester tester) async {
    final controller = AppSettingsController();
    await controller.loadSettings();
    await controller.setLocale(const Locale('en'));

    await tester.pumpWidget(
      AppSettingsScope(
        controller: controller,
        child: PhysicsCalcApp(settingsController: controller),
      ),
    );
    await tester.pumpAndSettle();

    // Verify 3 bottom navigation tabs exist in English
    expect(find.text('Calculator'), findsOneWidget);
    expect(find.text('Converter'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Verify English buttons and placeholders
    expect(find.text('Select Physical Quantity'), findsNWidgets(2));
    expect(find.text('Add Value'), findsOneWidget);
    expect(find.text('View Solution Report'), findsOneWidget);
  });

  testWidgets('Physics Calc+ Tema Değişimi Testi (ThemeMode switch)', (WidgetTester tester) async {
    final controller = AppSettingsController();
    await controller.loadSettings();

    await tester.pumpWidget(
      AppSettingsScope(
        controller: controller,
        child: PhysicsCalcApp(settingsController: controller),
      ),
    );
    await tester.pumpAndSettle();

    expect(controller.themeMode, ThemeMode.system);

    await controller.setThemeMode(ThemeMode.dark);
    await tester.pumpAndSettle();
    expect(controller.themeMode, ThemeMode.dark);

    await controller.setThemeMode(ThemeMode.light);
    await tester.pumpAndSettle();
    expect(controller.themeMode, ThemeMode.light);
  });
}
