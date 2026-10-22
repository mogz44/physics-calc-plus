import 'package:flutter/material.dart';
import 'features/calc_engine/presentation/screens/calc_screen.dart';
import 'features/converter/presentation/screens/converter_screen.dart';
import 'features/settings/presentation/screens/settings_screen.dart';

/// Uygulamanın 3 ana menüsünü barındıran navigasyon kabuğu:
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
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.calculate_outlined),
              selectedIcon: Icon(Icons.calculate),
              label: 'Hesaplayıcı',
            ),
            NavigationDestination(
              icon: Icon(Icons.sync_alt_outlined),
              selectedIcon: Icon(Icons.sync_alt),
              label: 'Dönüştürücü',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Ayarlar',
            ),
          ],
        ),
      ),
    );
  }
}
