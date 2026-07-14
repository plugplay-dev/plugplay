import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle appTitle = TextStyle(
    color: AppColors.primary,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle title = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitle = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 14,
  );

  static const TextStyle body = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 16,
  );

  static const TextStyle caption = TextStyle(
    color: AppColors.textHint,
    fontSize: 12,
  );

  static const TextStyle button = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}