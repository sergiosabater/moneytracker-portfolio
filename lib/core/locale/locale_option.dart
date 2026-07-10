import 'package:flutter/material.dart';

enum LocaleOption {
  system,
  en,
  es,
  fr,
  de,
  pl;

  Locale? toLocale() {
    switch (this) {
      case LocaleOption.system:
        return null;
      case LocaleOption.en:
        return const Locale('en');
      case LocaleOption.es:
        return const Locale('es');
      case LocaleOption.fr:
        return const Locale('fr');
      case LocaleOption.de:
        return const Locale('de');
      case LocaleOption.pl:
        return const Locale('pl');
    }
  }

  static LocaleOption fromStorageValue(String? value) {
    return LocaleOption.values.firstWhere(
      (option) => option.name == value,
      orElse: () => LocaleOption.system,
    );
  }

  String toStorageValue() => name;
}