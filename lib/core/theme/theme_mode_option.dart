import 'package:flutter/material.dart';

enum ThemeModeOption {
  light,
  dark,
  system;

  /// Converts to Flutter's native [ThemeMode], used directly by [MaterialApp].
  ThemeMode toThemeMode() {
    switch (this) {
      case ThemeModeOption.light:
        return ThemeMode.light;
      case ThemeModeOption.dark:
        return ThemeMode.dark;
      case ThemeModeOption.system:
        return ThemeMode.system;
    }
  }

  /// Parses a stored string value (from [PreferencesService]) back into
  /// a [ThemeModeOption], defaulting to [system] for unknown/missing values.
  static ThemeModeOption fromStorageValue(String? value) {
    switch (value) {
      case 'light':
        return ThemeModeOption.light;
      case 'dark':
        return ThemeModeOption.dark;
      default:
        return ThemeModeOption.system;
    }
  }

  /// Converts back to the string value used in [PreferencesService].
  String toStorageValue() => name;
}