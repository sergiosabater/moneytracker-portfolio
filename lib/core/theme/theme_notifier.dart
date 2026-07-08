import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:moneytracker/core/services/preferences_provider.dart';
import 'package:moneytracker/core/theme/theme_mode_option.dart';

part 'theme_notifier.g.dart';

@Riverpod(keepAlive: true)
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeModeOption build() {
    final preferences = ref.watch(preferencesServiceProvider);
    final storedValue = preferences.getThemeMode();
    return ThemeModeOption.fromStorageValue(storedValue);
  }

  /// Updates the current theme mode and persists the choice.
  Future<void> setThemeMode(ThemeModeOption option) async {
    state = option;
    final preferences = ref.read(preferencesServiceProvider);
    await preferences.saveThemeMode(option.toStorageValue());
  }
}