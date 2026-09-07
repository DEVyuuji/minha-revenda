import 'package:flutter/material.dart';

class AppTheme {
  static const brand = Color(0xFF6750A4);
  static const brandContainer = Color(0xFFEADDFF);
  static const onBrandContainer = Color(0xFF21005D);
  static const surface = Color(0xFFFFFBFE);
  static const surfaceVariant = Color(0xFFE7E0EC);
  static const onSurface = Color(0xFF1C1B1F);
  static const muted = Color(0xFF49454F);
  static const outline = Color(0xFFCAC4D0);
  static const outlineVariant = Color(0xFFE6E0EB);
  static const tertiary = Color(0xFF7D5260);
  static const tertiaryContainer = Color(0xFFFFD8E4);
  static const onTertiaryContainer = Color(0xFF31111D);
  static const error = Color(0xFFB3261E);
  static const errorContainer = Color(0xFFF9DEDC);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(seedColor: brand, brightness: Brightness.light).copyWith(
      primary: brand,
      onPrimary: Colors.white,
      primaryContainer: brandContainer,
      onPrimaryContainer: onBrandContainer,
      surface: surface,
      onSurface: onSurface,
      outline: outline,
      error: error,
      errorContainer: errorContainer,
      onErrorContainer: const Color(0xFF410E0B),
      tertiary: tertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
    );
    return ThemeData(useMaterial3: true, colorScheme: scheme, scaffoldBackgroundColor: surface, fontFamily: 'sans-serif');
  }
}
