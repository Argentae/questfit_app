import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// QuestFit design tokens ported from the PWA CSS tokens.
class QuestFitColors {
  static const bgDark = Color(0xFF0A0E1A);
  static const bgCard = Color(0xE6121C2C); // rgba(18,24,44,0.85) approx
  static const bgCardHover = Color(0xF218203A);
  static const glassBorder = Color(0x0FFFFFFF);
  static const gold = Color(0xFFF0C850);
  static const goldDim = Color(0xFFB8962E);
  static const emerald = Color(0xFF2DD4A8);
  static const emeraldGlow = Color(0x592DD4A8);
  static const purple = Color(0xFFA78BFA);
  static const purpleGlow = Color(0x4DA78BFA);
  static const redAccent = Color(0xFFF87171);
  static const blueAccent = Color(0xFF60A5FA);
  static const orangeAccent = Color(0xFFFB923C);
  static const textPrimary = Color(0xFFEEF0F6);
  static const textSecondary = Color(0x8CEEF0F6);
  static const textMuted = Color(0x4DEEF0F6);

  // Tier colors (v3.0: LoL-style 10-tier system)
  static const rankIron = Color(0xFF8B8B8B);
  static const rankBronze = Color(0xFFCD7F32);
  static const rankSilver = Color(0xFFC0C0C0);
  static const rankGold = Color(0xFFF0C850);
  static const rankPlatinum = Color(0xFF60A5FA);
  static const rankEmerald = Color(0xFF2DD4A8);
  static const rankDiamond = Color(0xFFA78BFA);
  static const rankMaster = Color(0xFFF87171);
  static const rankGrandmaster = Color(0xFFFF6B35);
  static const rankChallenger = Color(0xFF00D4FF);
}

/// Dark RPG theme for QuestFit.
ThemeData questFitTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: QuestFitColors.bgDark,
    primaryColor: QuestFitColors.emerald,
    colorScheme: const ColorScheme.dark(
      primary: QuestFitColors.emerald,
      secondary: QuestFitColors.gold,
      surface: QuestFitColors.bgCard,
      error: QuestFitColors.redAccent,
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 24,
          color: QuestFitColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: QuestFitColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: QuestFitColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: QuestFitColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: QuestFitColors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: QuestFitColors.textSecondary,
        ),
        labelSmall: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 10,
          color: QuestFitColors.textMuted,
          letterSpacing: 1.0,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: QuestFitColors.bgCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: QuestFitColors.glassBorder),
      ),
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xEB0A0E1A),
      selectedItemColor: QuestFitColors.emerald,
      unselectedItemColor: QuestFitColors.textMuted,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
    ),
  );
}

/// Glassmorphism card decoration.
BoxDecoration glassCard({double borderRadius = 20}) {
  return BoxDecoration(
    color: QuestFitColors.bgCard,
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: QuestFitColors.glassBorder),
  );
}

/// Gradient text shader for gold headings.
Shader goldGradientShader(Rect bounds) {
  return const LinearGradient(
    colors: [QuestFitColors.gold, Color(0xFFFFE08A)],
  ).createShader(bounds);
}
