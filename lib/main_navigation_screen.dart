import 'package:flutter/material.dart';
import 'core/localization/app_localizations.dart';
import 'screens/calc_screen.dart';
import 'screens/converter_screen.dart';
import 'screens/settings_screen.dart';

/// Uygulamanın 3 ana menüsünü barındıran navigasyon kabuğu (TR/EN yerelleştirilmiş):
/// 1. Hesaplayıcı (Physics Calc+) - Ana hesaplama ekranı
/// 2. Dönüştürücü (Converter) - Birim çevirici ekranı
/// 3. Ayarlar (Settings) - Ayarlar ve bilgi sekmesi
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    CalcScreen(),
    ConverterScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final loc = context.loc;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: colorScheme.outline,
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: colorScheme.surface,
          selectedIndex: _currentIndex,
          onDestinationSelected: (idx) {
            setState(() => _currentIndex = idx);
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.calculate_outlined),
              selectedIcon: const Icon(Icons.calculate),
              label: loc.navCalculator,
            ),
            NavigationDestination(
              icon: const Icon(Icons.sync_alt_outlined),
              selectedIcon: const Icon(Icons.sync_alt),
              label: loc.navConverter,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              label: loc.navSettings,
            ),
          ],
        ),
      ),
    );
  }
}
