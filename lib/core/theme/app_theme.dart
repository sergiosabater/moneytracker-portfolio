import 'package:flutter/material.dart';
import 'package:moneytracker/core/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        surface: AppColors.lightSurface,
      ),
      cardColor: AppColors.lightSurface,
      dividerColor: AppColors.lightBorder,
      textTheme: _textTheme(
        primaryColor: AppColors.lightTextPrimary,
        secondaryColor: AppColors.lightTextSecondary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryLight,
        brightness: Brightness.dark,
        primary: AppColors.primaryLight,
        surface: AppColors.darkSurface,
      ),
      cardColor: AppColors.darkSurface,
      dividerColor: AppColors.darkBorder,
      textTheme: _textTheme(
        primaryColor: AppColors.darkTextPrimary,
        secondaryColor: AppColors.darkTextSecondary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
      ),
    );
  }

  static TextTheme _textTheme({
    required Color primaryColor,
    required Color secondaryColor,
  }) {
    return TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.w900,
        color: primaryColor,
      ),
      bodyLarge: TextStyle(color: primaryColor),
      bodyMedium: TextStyle(color: secondaryColor),
    );
  }
}