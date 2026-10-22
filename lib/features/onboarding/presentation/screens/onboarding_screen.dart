import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/settings/app_settings_scope.dart';
import '../../../../main_navigation_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const int _totalPages = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() async {
    final settings = AppSettingsScope.of(context);
    await settings.setFirstRunDone();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip butonu (sağ üst)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextButton(
                  onPressed: _finishOnboarding,
                  child: Text(
                    loc.onboardingSkip,
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.55),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Sayfalar
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _OnboardingPage1(loc: loc),
                  _OnboardingPage2(loc: loc),
                  _OnboardingPage3(loc: loc),
                ],
              ),
            ),

            // Dot indikatörler + Navigasyon
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Column(
                children: [
                  // Dot göstergeler
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_totalPages, (i) {
                      final isActive = i == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? colorScheme.primary
                              : colorScheme.primary.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  // İlerleme butonu
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: _nextPage,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        _currentPage == _totalPages - 1
                            ? loc.onboardingStart
                            : loc.onboardingNext,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sayfa 1: Uygulama Tanıtımı
// ---------------------------------------------------------------------------
class _OnboardingPage1 extends StatelessWidget {
  final AppLocalizations loc;
  const _OnboardingPage1({required this.loc});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Logo + glow efekti
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
              border: Border.all(
                color: colorScheme.primary.withOpacity(0.35),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.18),
                  blurRadius: 32,
                  spreadRadius: 4,
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
          const SizedBox(height: 32),
          // Başlık
          Text(
            loc.onboardingPage1Title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
          ),
          const SizedBox(height: 16),
          // Alt başlık
          Text(
            loc.onboardingPage1Subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.65),
                  height: 1.55,
                ),
          ),
          const SizedBox(height: 36),
          // Özellik listesi
          _FeatureRow(icon: Icons.layers_rounded, label: loc.onboardingPage1Feature1),
          const SizedBox(height: 12),
          _FeatureRow(icon: Icons.device_hub_rounded, label: loc.onboardingPage1Feature2),
          const SizedBox(height: 12),
          _FeatureRow(icon: Icons.receipt_long_rounded, label: loc.onboardingPage1Feature3),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeatureRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: colorScheme.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sayfa 2: Dil & Tema Seçimi
// ---------------------------------------------------------------------------
class _OnboardingPage2 extends StatelessWidget {
  final AppLocalizations loc;
  const _OnboardingPage2({required this.loc});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final settings = AppSettingsScope.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary.withOpacity(0.1),
              ),
              child: Icon(
                Icons.tune_rounded,
                size: 52,
                color: colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            loc.onboardingPage2Title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            loc.onboardingPage2Subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.65),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 32),

          // --- TEMA SEÇİCİ ---
          Text(
            loc.onboardingPage2ThemeLabel,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
          ),
          const SizedBox(height: 10),
          ListenableBuilder(
            listenable: settings,
            builder: (context, _) {
              return Column(
                children: [
                  _SelectionTile(
                    label: loc.systemDefault,
                    icon: Icons.brightness_auto_rounded,
                    isSelected: settings.themeMode == ThemeMode.system,
                    onTap: () => settings.setThemeMode(ThemeMode.system),
                  ),
                  const SizedBox(height: 8),
                  _SelectionTile(
                    label: loc.themeLight,
                    icon: Icons.light_mode_rounded,
                    isSelected: settings.themeMode == ThemeMode.light,
                    onTap: () => settings.setThemeMode(ThemeMode.light),
                  ),
                  const SizedBox(height: 8),
                  _SelectionTile(
                    label: loc.themeDark,
                    icon: Icons.dark_mode_rounded,
                    isSelected: settings.themeMode == ThemeMode.dark,
                    onTap: () => settings.setThemeMode(ThemeMode.dark),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 28),

          // --- DİL SEÇİCİ ---
          Text(
            loc.onboardingPage2LangLabel,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
          ),
          const SizedBox(height: 10),
          ListenableBuilder(
            listenable: settings,
            builder: (context, _) {
              final currentLang = settings.locale?.languageCode ?? 'system';
              return Column(
                children: [
                  _SelectionTile(
                    label: loc.turkish,
                    icon: Icons.language_rounded,
                    isSelected: currentLang == 'tr',
                    onTap: () => settings.setLocale(const Locale('tr')),
                  ),
                  const SizedBox(height: 8),
                  _SelectionTile(
                    label: loc.english,
                    icon: Icons.language_rounded,
                    isSelected: currentLang == 'en',
                    onTap: () => settings.setLocale(const Locale('en')),
                  ),
                  const SizedBox(height: 8),
                  _SelectionTile(
                    label: loc.systemDefault,
                    icon: Icons.phone_android_rounded,
                    isSelected: currentLang == 'system',
                    onTap: () => settings.setLocale(null),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _SelectionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectionTile({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withOpacity(0.12)
              : colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.5),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? colorScheme.primary : null,
                    ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, size: 20, color: colorScheme.primary),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sayfa 3: Nasıl Kullanılır?
// ---------------------------------------------------------------------------
class _OnboardingPage3 extends StatelessWidget {
  final AppLocalizations loc;
  const _OnboardingPage3({required this.loc});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withOpacity(0.1),
            ),
            child: Icon(
              Icons.school_rounded,
              size: 52,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            loc.onboardingPage3Title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            loc.onboardingPage3Subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.65),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 32),
          _StepCard(stepNumber: 1, label: loc.onboardingPage3Step1),
          const SizedBox(height: 12),
          _StepCard(stepNumber: 2, label: loc.onboardingPage3Step2),
          const SizedBox(height: 12),
          _StepCard(stepNumber: 3, label: loc.onboardingPage3Step3),
          const SizedBox(height: 12),
          _StepCard(stepNumber: 4, label: loc.onboardingPage3Step4),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final int stepNumber;
  final String label;

  const _StepCard({required this.stepNumber, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$stepNumber',
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
