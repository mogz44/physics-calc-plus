import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:physics_calc/screens/onboarding_screen.dart';
import 'core/localization/app_localizations.dart';
import 'core/settings/app_settings_controller.dart';
import 'core/settings/app_settings_scope.dart';
import 'core/theme/app_theme.dart';
import 'main_navigation_screen.dart'; 

class PhysicsCalcApp extends StatelessWidget {
  final AppSettingsController? settingsController;
  final bool? isFirstRun;

  const PhysicsCalcApp({
    super.key, 
    this.settingsController,
    this.isFirstRun,
  });

  @override
  Widget build(BuildContext context) {
    // Controller varsa onu kullan, yoksa Scope'tan al
    final settings = settingsController ?? AppSettingsScope.of(context);

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final showOnboarding = isFirstRun ?? settings.isFirstRun;

        return MaterialApp(
          title: 'Physics Calc+',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settings.themeMode,
          locale: settings.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: showOnboarding 
              ? const OnboardingScreen() 
              : const MainNavigationScreen(),
        );
      },
    );
  }
}
