import 'package:flutter/material.dart';
import '../core/localization/app_localizations.dart';
import '../core/settings/app_settings_scope.dart';
import '../main_navigation_screen.dart';

/// Physics Calc+ Zero-Friction Fluid Onboarding Flow
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
  void initState() {
    super.initState();
    // Sıfır sürtünme: İlk açılışta varsayılan olarak Dark Mode ve Sistem dilini garantiye al
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final settings = AppSettingsScope.of(context);
      // Henüz tema açıkça ayarlanmadıysa Dark Mode'a çek
      if (settings.themeMode == ThemeMode.system) {
        settings.setThemeMode(ThemeMode.dark);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() async {
    final settings = AppSettingsScope.of(context);
    await settings.setFirstRunDone();
    if (!mounted) return;

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Üst Bar: Logo Amblem ve Atla (Skip) Butonu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.primary.withValues(alpha: 0.15),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/icon/app_logo.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.science_rounded,
                              size: 18,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Physics Calc+',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.4,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _finishOnboarding,
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.onSurface.withValues(alpha: 0.6),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Text(
                      loc.onboardingSkip,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            // 3 Sayfalı Akıcı Slider
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

            // Alt Navigasyon: Dots & Ana Aksiyon Butonu
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Sayfa Göstergeleri (Dots)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_totalPages, (i) {
                      final isActive = i == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? colorScheme.primary
                              : colorScheme.primary.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // "Devam" / "Başla" Butonu (Zero-Friction)
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: _nextPage,
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        elevation: 0,
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
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
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
// 1. Sayfa: Hoş Geldiniz & Dikey Kart Mimarisi Tanıtımı
// ---------------------------------------------------------------------------
class _OnboardingPage1 extends StatelessWidget {
  final AppLocalizations loc;
  const _OnboardingPage1({required this.loc});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Görsel Amblem & Neon Glow
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surfaceContainerHigh,
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.35),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  blurRadius: 28,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/icon/app_logo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.auto_graph_rounded,
                  size: 44,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Başlık
          Text(
            loc.onboardingPage1Title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
          ),
          const SizedBox(height: 12),

          // Açıklama
          Text(
            loc.onboardingPage1Subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 28),

          // Dikey Kart Tasarım Ögeleri
          _FeatureCard(
            icon: Icons.layers_outlined,
            title: loc.onboardingPage1Feature1,
          ),
          const SizedBox(height: 10),
          _FeatureCard(
            icon: Icons.hub_outlined,
            title: loc.onboardingPage1Feature2,
          ),
          const SizedBox(height: 10),
          _FeatureCard(
            icon: Icons.receipt_long_outlined,
            title: loc.onboardingPage1Feature3,
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FeatureCard({required this.icon, required this.title});

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
              color: colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: colorScheme.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. Sayfa: Hızlı Tercihler (Dil & Tema - Önceden Seçili & Reaktif)
// ---------------------------------------------------------------------------
class _OnboardingPage2 extends StatelessWidget {
  final AppLocalizations loc;
  const _OnboardingPage2({required this.loc});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final settings = AppSettingsScope.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary.withValues(alpha: 0.12),
              ),
              child: Icon(
                Icons.tune_rounded,
                size: 40,
                color: colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              loc.onboardingPage2Title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              loc.onboardingPage2Subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurface.withValues(alpha: 0.65),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // TEMA SEÇENEKLERİ (Önceden Koyu Mod seçili)
          Text(
            loc.onboardingPage2ThemeLabel.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 10),
          ListenableBuilder(
            listenable: settings,
            builder: (context, _) {
              return Row(
                children: [
                  Expanded(
                    child: _SelectableCard(
                      label: loc.themeDark,
                      icon: Icons.dark_mode_rounded,
                      isSelected: settings.themeMode == ThemeMode.dark,
                      onTap: () => settings.setThemeMode(ThemeMode.dark),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _SelectableCard(
                      label: loc.themeLight,
                      icon: Icons.light_mode_rounded,
                      isSelected: settings.themeMode == ThemeMode.light,
                      onTap: () => settings.setThemeMode(ThemeMode.light),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _SelectableCard(
                      label: loc.systemDefault,
                      icon: Icons.brightness_auto_rounded,
                      isSelected: settings.themeMode == ThemeMode.system,
                      onTap: () => settings.setThemeMode(ThemeMode.system),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          // DİL SEÇENEKLERİ (Önceden Sistem Dili seçili)
          Text(
            loc.onboardingPage2LangLabel.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 10),
          ListenableBuilder(
            listenable: settings,
            builder: (context, _) {
              final currentCode = settings.locale?.languageCode ?? 'system';
              return Column(
                children: [
                  _LanguageTile(
                    code: 'SYS',
                    label: loc.systemDefault,
                    isSelected: currentCode == 'system',
                    onTap: () => settings.setLocale(null),
                  ),
                  const SizedBox(height: 8),
                  _LanguageTile(
                    code: 'TR',
                    label: loc.turkish,
                    isSelected: currentCode == 'tr',
                    onTap: () => settings.setLocale(const Locale('tr')),
                  ),
                  const SizedBox(height: 8),
                  _LanguageTile(
                    code: 'EN',
                    label: loc.english,
                    isSelected: currentCode == 'en',
                    onTap: () => settings.setLocale(const Locale('en')),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SelectableCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectableCard({
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
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.12)
              : colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? colorScheme.primary : colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final String code;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.code,
    required this.label,
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.12)
              : colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                code,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? colorScheme.primary : colorScheme.onSurface,
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
// 3. Sayfa: Başlamaya Hazır & Temel İpuçları
// ---------------------------------------------------------------------------
class _OnboardingPage3 extends StatelessWidget {
  final AppLocalizations loc;
  const _OnboardingPage3({required this.loc});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withValues(alpha: 0.12),
            ),
            child: Icon(
              Icons.rocket_launch_rounded,
              size: 44,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            loc.onboardingPage3Title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            loc.onboardingPage3Subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurface.withValues(alpha: 0.65),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),

          _TipStepCard(stepNumber: 1, text: loc.onboardingPage3Step1),
          const SizedBox(height: 10),
          _TipStepCard(stepNumber: 2, text: loc.onboardingPage3Step2),
          const SizedBox(height: 10),
          _TipStepCard(stepNumber: 3, text: loc.onboardingPage3Step3),
          const SizedBox(height: 10),
          _TipStepCard(stepNumber: 4, text: loc.onboardingPage3Step4),
        ],
      ),
    );
  }
}

class _TipStepCard extends StatelessWidget {
  final int stepNumber;
  final String text;

  const _TipStepCard({required this.stepNumber, required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
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
              text,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
