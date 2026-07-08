import 'package:shared_preferences/shared_preferences.dart';

/// Centralized wrapper around [SharedPreferences], the standard key-value
/// storage for simple user settings (theme, language, currency).

class PreferencesService {
  static const _themeModeKey = 'theme_mode';
  static const _languageKey = 'language';
  static const _currencyKey = 'currency';

  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  /// Creates a [PreferencesService] instance, awaiting the underlying
  /// [SharedPreferences] singleton to be ready.
  static Future<PreferencesService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return PreferencesService(prefs);
  }

  // --- Theme mode: 'light' | 'dark' | 'system' ---

  String? getThemeMode() => _prefs.getString(_themeModeKey);

  Future<void> saveThemeMode(String value) =>
      _prefs.setString(_themeModeKey, value);

  // --- Language: 'system' | 'es' | 'en' | 'fr' | 'de' | 'pl' ---

  String? getLanguage() => _prefs.getString(_languageKey);

  Future<void> saveLanguage(String value) =>
      _prefs.setString(_languageKey, value);

  // --- Currency: 'usd' | 'eur' | 'gbp' | 'pln' ---

  String? getCurrency() => _prefs.getString(_currencyKey);

  Future<void> saveCurrency(String value) =>
      _prefs.setString(_currencyKey, value);
}