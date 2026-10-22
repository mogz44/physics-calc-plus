import 'package:flutter/material.dart';

/// 3. Menü: Ayarlar (Settings) Sekmesi
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
            const Text('Ayarlar'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // 1. BÖLÜM: HESAPLAMA & MOTOR AYARLARI
          _buildSectionHeader(context, 'HESAPLAMA MOTORU'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.tune_rounded, color: colorScheme.primary),
                  title: const Text('Ondalık Hassasiyeti'),
                  subtitle: const Text('Varsayılan 4 basamak (Akıllı formatlama)'),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '4 Hane',
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
                  title: const Text('Otomatik SI Normalizasyonu'),
                  subtitle: const Text('Farklı birimler hesaplama öncesi SI tabanına çevrilir'),
                  trailing: Icon(Icons.check_circle_rounded, color: colorScheme.primary),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.shield_outlined, color: colorScheme.primary),
                  title: const Text('Sıfıra Bölünme Koruması'),
                  subtitle: const Text('Matematiksel kısıtlar (isValid) denetlenir'),
                  trailing: Icon(Icons.check_circle_rounded, color: colorScheme.primary),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 2. BÖLÜM: GÖRÜNÜM & TEMA
          _buildSectionHeader(context, 'GÖRÜNÜM'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.palette_outlined, color: colorScheme.primary),
                  title: const Text('Renk Paleti'),
                  subtitle: const Text('Minimalist Koyu (#00D2D3) / Açık (#007AFF)'),
                  trailing: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.outline, width: 2),
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.view_agenda_outlined, color: colorScheme.primary),
                  title: const Text('Kart Mimarisi'),
                  subtitle: const Text('Dikey Esnek Kart (Stacked) Tasarımı'),
                  trailing: const Text(
                    'Aktif',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 3. BÖLÜM: HAKKINDA & LİSANS
          _buildSectionHeader(context, 'HAKKINDA & LİSANS'),
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
                  title: const Text('Lisans'),
                  subtitle: const Text('GNU General Public License v3.0 (GPL-3.0)'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.phonelink_setup_rounded, color: colorScheme.primary),
                  title: const Text('F-Droid ve Gizlilik'),
                  subtitle: const Text('%100 Çevrimdışı, Sıfır Takipçi, Tamamen Açık Kaynak'),
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
