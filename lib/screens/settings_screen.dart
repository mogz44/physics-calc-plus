import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'onboarding_screen.dart';
import '../core/localization/app_localizations.dart';
import '../core/settings/app_settings_controller.dart';
import '../core/settings/app_settings_scope.dart';

/// 3. Menü: Ayarlar (Settings) Sekmesi (Görünüm, Dil, Rehber & Geliştirici Bilgileri)
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
                customLeading: _buildBadge(context, 'SYS', colorScheme.primary),
                isSelected: currentCode == 'system',
                onTap: () {
                  controller.setLocale(null); // Sistem dili
                  Navigator.pop(ctx);
                },
              ),
              _buildDialogOption(
                context,
                title: loc.turkish,
                customLeading: _buildBadge(context, 'TR', colorScheme.primary),
                isSelected: currentCode == 'tr',
                onTap: () {
                  controller.setLocale(const Locale('tr'));
                  Navigator.pop(ctx);
                },
              ),
              _buildDialogOption(
                context,
                title: loc.english,
                customLeading: _buildBadge(context, 'EN', colorScheme.primary),
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

  static Widget _buildBadge(BuildContext context, String text, Color primary) {
    return Container(
      width: 34,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: primary.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: primary,
          letterSpacing: 0.5,
        ),
      ),
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
      leading: customLeading ??
          (icon != null
              ? Icon(icon, color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant)
              : null),
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

  Future<void> _openUrl(BuildContext context, String urlString) async {
    final uri = Uri.parse(urlString);
    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $urlString')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
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
          // 1. BÖLÜM: GÖRÜNÜM & TERCİHLER
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

                // Kullanım Rehberini Tekrar Gör (Re-open Onboarding)
                ListTile(
                  leading: Icon(Icons.help_outline_rounded, color: colorScheme.primary),
                  title: Text(loc.viewOnboardingAgain),
                  subtitle: Text(loc.viewOnboardingSubtitle),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const OnboardingScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 2. BÖLÜM: HAKKINDA & LİSANS
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
                  subtitle: Text('org.mogz.physicscalc • ${loc.appVersion}'),
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

          const SizedBox(height: 28),

          // 3. GELİŞTİRİCİ FOOTER'I
          _buildDeveloperFooter(context),

          const SizedBox(height: 16),
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

  Widget _buildDeveloperFooter(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final loc = context.loc;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo amblemi
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.35),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/icon/app_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Sürüm ve Geliştirici İmzası
          Text(
            loc.appVersion,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            loc.developedBy,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          // GPL-3.0 Lisans etiketi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.gavel_rounded, size: 13, color: colorScheme.primary),
                const SizedBox(width: 5),
                Text(
                  'GPL-3.0 License',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // GitHub ve IzzyOnDroid Butonları
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () => _openUrl(
                  context,
                  'https://github.com/mogz44/physics-calc-plus',
                ),
                icon: const Icon(Icons.code_rounded, size: 16),
                label: Text(loc.githubLink),
                style: OutlinedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: colorScheme.primary,
                  side: BorderSide(
                    color: colorScheme.primary.withValues(alpha: 0.35),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () => _openUrl(
                  context,
                  'https://apt.izzysoft.de/fdroid/',
                ),
                icon: const Icon(Icons.shop_2_outlined, size: 16),
                label: Text(loc.izzyLink),
                style: OutlinedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: colorScheme.primary,
                  side: BorderSide(
                    color: colorScheme.primary.withValues(alpha: 0.35),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
