import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:moneytracker/core/locale/locale_option.dart';
import 'package:moneytracker/core/services/preferences_provider.dart';

part 'locale_notifier.g.dart';

@Riverpod(keepAlive: true)
class LocaleNotifier extends _$LocaleNotifier {
  @override
  LocaleOption build() {
    final preferences = ref.watch(preferencesServiceProvider);
    final storedValue = preferences.getLanguage();
    return LocaleOption.fromStorageValue(storedValue);
  }

  Future<void> setLocale(LocaleOption option) async {
    state = option;
    final preferences = ref.read(preferencesServiceProvider);
    await preferences.saveLanguage(option.toStorageValue());
  }
}