import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryAccent,
        surface: AppColors.surface,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),

      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.sliderActive,
        inactiveTrackColor: AppColors.sliderInactive,
        thumbColor: AppColors.primary,
      ),

      iconTheme: const IconThemeData(
        color: AppColors.iconPrimary,
      ),

      useMaterial3: true,
    );
  }
}