import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:moneytracker/core/currency/currency_option.dart';
import 'package:moneytracker/core/locale/locale_notifier.dart';
import 'package:moneytracker/core/services/preferences_provider.dart';

part 'currency_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrencyNotifier extends _$CurrencyNotifier {
  @override
  CurrencyOption build() {
    final preferences = ref.watch(preferencesServiceProvider);
    final storedValue = preferences.getCurrency();

    if (storedValue == null) {
      final locale = ref.watch(localeNotifierProvider);
      return CurrencyOption.forLocale(locale);
    }

    return CurrencyOption.fromStorageValue(storedValue);
  }

  Future<void> setCurrency(CurrencyOption option) async {
    state = option;
    final preferences = ref.read(preferencesServiceProvider);
    await preferences.saveCurrency(option.toStorageValue());
  }
}