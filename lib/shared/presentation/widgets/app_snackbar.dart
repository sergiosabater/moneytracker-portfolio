import 'package:flutter/material.dart';
import 'package:moneytracker/core/theme/app_colors.dart';

enum AppSnackbarType { success, error, info }

class AppSnackbar {
  AppSnackbar._();

  static void show(
    BuildContext context, {
    required String message,
    required AppSnackbarType type,
    Duration duration = const Duration(seconds: 2),
  }) {
    final theme = Theme.of(context);
    final (backgroundColor, icon) = _styleFor(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: duration,
        elevation: theme.brightness == Brightness.dark ? 8 : 4,
      ),
    );
  }

  static (Color, IconData) _styleFor(AppSnackbarType type) {
    switch (type) {
      case AppSnackbarType.success:
        return (AppColors.income, Icons.check_circle_outline);
      case AppSnackbarType.error:
        return (AppColors.error, Icons.error_outline);
      case AppSnackbarType.info:
        return (AppColors.info, Icons.info_outline);
    }
  }
}