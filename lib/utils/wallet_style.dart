import 'package:flutter/material.dart';

/// ENUM untuk daftar tema yang tersedia
enum WalletThemeType {
  neumorphismLite,
  oceanBreeze,
  neonPurple,
  emeraldGlow,
}

/// MODEL untuk struktur warna tema
class WalletTheme {
  final Color primaryColor;
  final Color secondaryColor;
  final Color buttonColor;

  const WalletTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.buttonColor,
  });
}

/// DATABASE tema
class WalletThemeData {
  static const Map<WalletThemeType, WalletTheme> themes = {
    WalletThemeType.neumorphismLite: WalletTheme(
      primaryColor: Color(0xff1A56DB),
      secondaryColor: Color(0xFFFFFFFF),
      buttonColor: Color(0xFF000000),
    ),
    WalletThemeType.oceanBreeze: WalletTheme(
      primaryColor: Color(0xFF1A73E8),
      secondaryColor: Color(0xFF4D8FF0),
      buttonColor: Color(0xFF202124),
    ),
    WalletThemeType.neonPurple: WalletTheme(
      primaryColor: Color(0xFF6C4BFF),
      secondaryColor: Color(0xFF8A6DFF),
      buttonColor: Color(0xFF1C1A27),
    ),
    WalletThemeType.emeraldGlow: WalletTheme(
      primaryColor: Color(0xFF059669),
      secondaryColor: Color(0xFF34D399),
      buttonColor: Color(0xFF064E3B),
    ),
  };

  /// Fungsi untuk mengambil theme berdasarkan enum
  static WalletTheme get(WalletThemeType type) {
    return themes[type]!;
  }
}
