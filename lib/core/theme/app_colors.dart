import 'package:flutter/material.dart';

/// Centralized color palette for the entire app.
/// Any widget needing a color should reference this class instead of
/// using raw `Colors.xxx` values, so the whole app can be restyled
/// from a single source of truth.
class AppColors {
  AppColors._(); // Prevents instantiation — this class only holds constants.

  // --- Brand colors (shared between light and dark) ---
  static const Color primary = Color(0xFF00695C); // teal.shade800
  static const Color primaryMedium = Color(0xFF00897B); // teal.shade600
  static const Color primaryLight = Color(0xFF26A69A); // teal.shade400
  static const Color accent = Color(0xFF009688); // Colors.teal (shade 500)

  // --- Semantic colors (same across light and dark themes) ---
  static const Color income = Color(0xFF66BB6A); // green.shade400
  static const Color expense = Color(0xFFEF5350); // red.shade400
  static const Color error = Color(0xFFF44336); // red
  static const Color warning = Color(0xFFFF9800); // orange
  static const Color info = Color(0xFF2196F3); // blue
  static const Color security = Color(0xFF673AB7); // deepPurple

  // --- Light theme ---
  static const Color lightBackground = Color(0xFFFAFAFA); // grey.shade50
  static const Color lightSurface = Colors.white;
  static const Color lightTextPrimary = Color(0xFF000000); // black87 approx.
  static const Color lightTextSecondary = Color(0xFF757575); // grey.shade600
  static const Color lightBorder = Color(0xFFF5F5F5); // grey.shade100

  // --- Dark theme ---
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkBorder = Color(0xFF2C2C2C);
}