import 'package:moneytracker/core/locale/locale_option.dart';

enum CurrencyOption {
  usd,
  eur,
  gbp,
  pln;

  static CurrencyOption fromStorageValue(String? value) {
    return CurrencyOption.values.firstWhere(
      (option) => option.name == value,
      orElse: () => CurrencyOption.usd,
    );
  }

  String toStorageValue() => name;

  static CurrencyOption forLocale(LocaleOption locale) {
    switch (locale) {
      case LocaleOption.es:
      case LocaleOption.fr:
      case LocaleOption.de:
        return CurrencyOption.eur;
      case LocaleOption.en:
        return CurrencyOption.gbp;
      case LocaleOption.pl:
        return CurrencyOption.pln;
    }
  }
}