import 'dart:ui';

enum LocaleOption {
  en,
  es,
  fr,
  de,
  pl;

  Locale toLocale() {
    switch (this) {
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

  static LocaleOption resolveDeviceDefault() {
    final deviceLanguageCode = PlatformDispatcher.instance.locale.languageCode;
    return LocaleOption.values.firstWhere(
      (option) => option.name == deviceLanguageCode,
      orElse: () => LocaleOption.en,
    );
  }

  static LocaleOption fromStorageValue(String? value) {
    if (value == null) return resolveDeviceDefault();
    return LocaleOption.values.firstWhere(
      (option) => option.name == value,
      orElse: () => resolveDeviceDefault(),
    );
  }

  String toStorageValue() => name;
}