import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tema ve Dil tercihlerini yöneten ve SharedPreferences ile kalıcı kılan Controller.
class AppSettingsController extends ChangeNotifier {
  static const String _keyThemeMode = 'pref_theme_mode';
  static const String _keyLanguageCode = 'pref_language_code';

  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;
  bool _isLoaded = false;

  ThemeMode get themeMode => _themeMode;
  Locale? get locale => _locale;
  bool get isLoaded => _isLoaded;

  /// SharedPreferences'tan kayıtlı ayarları yükler.
  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Tema tercihi
      final themeStr = prefs.getString(_keyThemeMode);
      if (themeStr == 'light') {
        _themeMode = ThemeMode.light;
      } else if (themeStr == 'dark') {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.system;
      }

      // Dil tercihi
      final langStr = prefs.getString(_keyLanguageCode);
      if (langStr == 'tr') {
        _locale = const Locale('tr');
      } else if (langStr == 'en') {
        _locale = const Locale('en');
      } else {
        _locale = null; // Sistem varsayılanı
      }
    } catch (e) {
      debugPrint('Ayar yükleme hatası: $e');
    } finally {
      _isLoaded = true;
      notifyListeners();
    }
  }

  /// Tema modunu günceller ve hafızaya yazar.
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String val = 'system';
      if (mode == ThemeMode.light) val = 'light';
      if (mode == ThemeMode.dark) val = 'dark';
      await prefs.setString(_keyThemeMode, val);
    } catch (e) {
      debugPrint('Tema kaydetme hatası: $e');
    }
  }

  /// Uygulama dilini günceller ve hafızaya yazar.
  Future<void> setLocale(Locale? newLocale) async {
    if (_locale == newLocale) return;
    _locale = newLocale;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      if (newLocale == null) {
        await prefs.setString(_keyLanguageCode, 'system');
      } else {
        await prefs.setString(_keyLanguageCode, newLocale.languageCode);
      }
    } catch (e) {
      debugPrint('Dil kaydetme hatası: $e');
    }
  }
}
