import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/settings/app_settings_controller.dart';
import '../../../../core/settings/app_settings_scope.dart';

/// 3. Menü: Ayarlar (Settings) Sekmesi (TR/EN & Tema Modu Yönetimi)
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showThemeDialog(BuildContext context, AppSettingsController controller) {
    final loc = context.loc;
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(loc.themeSetting),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogOption(
                context,
                title: loc.themeSystem,
                icon: Icons.brightness_auto_rounded,
                isSelected: controller.themeMode == ThemeMode.system,
                onTap: () {
                  controller.setThemeMode(ThemeMode.system);
                  Navigator.pop(ctx);
                },
              ),
              _buildDialogOption(
                context,
                title: loc.themeDark,
                icon: Icons.dark_mode_rounded,
                isSelected: controller.themeMode == ThemeMode.dark,
                onTap: () {
                  controller.setThemeMode(ThemeMode.dark);
                  Navigator.pop(ctx);
                },
              ),
              _buildDialogOption(
                context,
                title: loc.themeLight,
                icon: Icons.light_mode_rounded,
                isSelected: controller.themeMode == ThemeMode.light,
                onTap: () {
                  controller.setThemeMode(ThemeMode.light);
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
              child: Text(MaterialLocalizations.of(context).closeButtonLabel),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context, AppSettingsController controller) {
    final loc = context.loc;
    final colorScheme = Theme.of(context).colorScheme;
    final currentCode = controller.locale?.languageCode ?? 'system';

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(loc.languageSetting),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogOption(
                context,
                title: loc.themeSystem,
                icon: Icons.language_rounded,
                isSelected: currentCode == 'system',
                onTap: () {
                  controller.setLocale(null); // Sistem dili
                  Navigator.pop(ctx);
                },
              ),
              _buildDialogOption(
                context,
                title: loc.turkish,
                customLeading: const Text('🇹🇷', style: TextStyle(fontSize: 22)),
                isSelected: currentCode == 'tr',
                onTap: () {
                  controller.setLocale(const Locale('tr'));
                  Navigator.pop(ctx);
                },
              ),
              _buildDialogOption(
                context,
                title: loc.english,
                customLeading: const Text('🇬🇧', style: TextStyle(fontSize: 22)),
                isSelected: currentCode == 'en',
                onTap: () {
                  controller.setLocale(const Locale('en'));
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
              child: Text(MaterialLocalizations.of(context).closeButtonLabel),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildDialogOption(
    BuildContext context, {
    required String title,
    IconData? icon,
    Widget? customLeading,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: customLeading ?? (icon != null ? Icon(icon, color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant) : null),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle_rounded, color: colorScheme.primary)
          : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final loc = context.loc;
    final settings = AppSettingsScope.of(context);

    // Aktif tema metni
    String currentThemeLabel = loc.themeSystem;
    if (settings.themeMode == ThemeMode.dark) {
      currentThemeLabel = loc.themeDark;
    } else if (settings.themeMode == ThemeMode.light) {
      currentThemeLabel = loc.themeLight;
    }

    // Aktif dil metni
    String currentLangLabel = loc.themeSystem;
    if (settings.locale?.languageCode == 'tr') {
      currentLangLabel = loc.turkish;
    } else if (settings.locale?.languageCode == 'en') {
      currentLangLabel = loc.english;
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.settings_rounded,
                color: colorScheme.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            Text(loc.settingsTitle),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // 1. BÖLÜM: GÖRÜNÜM & DİL
          _buildSectionHeader(context, loc.appearanceSection),
          Card(
            child: Column(
              children: [
                // Tema Seçici
                ListTile(
                  leading: Icon(
                    settings.themeMode == ThemeMode.dark
                        ? Icons.dark_mode_rounded
                        : (settings.themeMode == ThemeMode.light
                            ? Icons.light_mode_rounded
                            : Icons.brightness_auto_rounded),
                    color: colorScheme.primary,
                  ),
                  title: Text(loc.themeSetting),
                  subtitle: Text(currentThemeLabel),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => _showThemeDialog(context, settings),
                ),
                const Divider(height: 1),

                // Dil Seçici
                ListTile(
                  leading: Icon(Icons.translate_rounded, color: colorScheme.primary),
                  title: Text(loc.languageSetting),
                  subtitle: Text(currentLangLabel),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => _showLanguageDialog(context, settings),
                ),
                const Divider(height: 1),

                // Kart Mimarisi Bilgisi
                ListTile(
                  leading: Icon(Icons.view_agenda_outlined, color: colorScheme.primary),
                  title: Text(loc.cardArchitecture),
                  subtitle: Text(loc.cardArchitectureSubtitle),
                  trailing: Text(
                    loc.active,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 2. BÖLÜM: HESAPLAMA & MOTOR AYARLARI
          _buildSectionHeader(context, loc.calcEngineSection),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.tune_rounded, color: colorScheme.primary),
                  title: Text(loc.decimalPrecision),
                  subtitle: Text(loc.decimalPrecisionSubtitle),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      loc.digitsCount,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.sync_rounded, color: colorScheme.primary),
                  title: Text(loc.autoSiNormalization),
                  subtitle: Text(loc.autoSiSubtitle),
                  trailing: Icon(Icons.check_circle_rounded, color: colorScheme.primary),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.shield_outlined, color: colorScheme.primary),
                  title: Text(loc.zeroDivisionGuard),
                  subtitle: Text(loc.zeroDivisionSubtitle),
                  trailing: Icon(Icons.check_circle_rounded, color: colorScheme.primary),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 3. BÖLÜM: HAKKINDA & LİSANS
          _buildSectionHeader(context, loc.aboutSection),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'assets/icon/app_logo.png',
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: const Text('Physics Calc+'),
                  subtitle: const Text('org.mogz.physicscalc • v1.0.0'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.verified_user_outlined, color: colorScheme.primary),
                  title: Text(loc.license),
                  subtitle: Text(loc.licenseGpl),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.phonelink_setup_rounded, color: colorScheme.primary),
                  title: Text(loc.privacyFdroid),
                  subtitle: Text(loc.privacySubtitle),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
