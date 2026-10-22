import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // --- DARK THEME RENK PALETİ ---
  static const Color darkPrimary = Color(0xFF00D2D3);        // Elektrik Mavisi (Vurgular, ana butonlar, aktif ikonlar)
  static const Color darkBackground = Color(0xFF06141B);     // Derin lacivert/siyah (Scaffold)
  static const Color darkSurface = Color(0xFF11212D);        // Koyu mavi-gri (Kartlar, Surface)
  static const Color darkBorder = Color(0xFF253745);         // Çerçeveler ve ayrım çizgileri
  static const Color darkMutedText = Color(0xFF4A5C6A);      // Birimler, ikincil etiketler
  static const Color darkPrimaryText = Color(0xFFCCD0CF);    // Ana başlıklar, değerler, açık gri

  // --- LIGHT THEME RENK PALETİ ---
  static const Color lightPrimary = Color(0xFF007AFF);       // Derin Elektrik Mavisi
  static const Color lightBackground = Color(0xFFF2F2F2);    // Soft açık gri arka plan
  static const Color lightSurface = Color(0xFFFFFFFF);       // Saf beyaz kartlar
  static const Color lightBorder = Color(0xFFE0E0E0);        // İnce gri kenarlıklar
  static const Color lightMutedText = Color(0xFF6C757D);     // Koyu gri ikincil metinler
  static const Color lightPrimaryText = Color(0xFF1A1A1A);   // Koyu font

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: darkPrimary,
        onPrimary: darkBackground,
        surface: darkSurface,
        onSurface: darkPrimaryText,
        outline: darkBorder,
        onSurfaceVariant: darkMutedText,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: darkBackground,
        foregroundColor: darkPrimaryText,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: darkPrimaryText,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: darkBorder, width: 1),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: darkSurface,
        elevation: 0,
        indicatorColor: darkPrimary.withValues(alpha: 0.15),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: darkPrimary);
          }
          return const IconThemeData(color: darkMutedText);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: darkPrimary,
            );
          }
          return const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: darkMutedText,
          );
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        hintStyle: const TextStyle(color: darkMutedText, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: darkBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: darkBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: darkPrimary, width: 1.5),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: darkBorder,
        thickness: 1,
        space: 1,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: darkPrimaryText),
        bodyMedium: TextStyle(color: darkPrimaryText),
        bodySmall: TextStyle(color: darkMutedText),
        titleLarge: TextStyle(color: darkPrimaryText, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: darkPrimaryText, fontWeight: FontWeight.w600),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        onPrimary: Colors.white,
        surface: lightSurface,
        onSurface: lightPrimaryText,
        outline: lightBorder,
        onSurfaceVariant: lightMutedText,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: lightBackground,
        foregroundColor: lightPrimaryText,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: lightPrimaryText,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: lightBorder, width: 1),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: lightSurface,
        elevation: 0,
        indicatorColor: lightPrimary.withValues(alpha: 0.12),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: lightPrimary);
          }
          return const IconThemeData(color: lightMutedText);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: lightPrimary,
            );
          }
          return const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: lightMutedText,
          );
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        hintStyle: const TextStyle(color: lightMutedText, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: lightBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: lightBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: lightPrimary, width: 1.5),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: lightBorder,
        thickness: 1,
        space: 1,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: lightPrimaryText),
        bodyMedium: TextStyle(color: lightPrimaryText),
        bodySmall: TextStyle(color: lightMutedText),
        titleLarge: TextStyle(color: lightPrimaryText, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: lightPrimaryText, fontWeight: FontWeight.w600),
      ),
    );
  }
}
