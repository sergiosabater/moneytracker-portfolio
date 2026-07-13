// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'MONEY TRACKER';

  @override
  String get balance => 'Saldo:';

  @override
  String get incomes => 'Przychody';

  @override
  String get expenses => 'Wydatki';

  @override
  String get newTransaction => 'Nowa transakcja';

  @override
  String get income => 'Przychód';

  @override
  String get expense => 'Wydatek';

  @override
  String get amount => 'KWOTA';

  @override
  String get description => 'OPIS';

  @override
  String get enterDescription => 'Wprowadź opis';

  @override
  String get noDescription => 'Brak opisu';

  @override
  String get add => 'Dodaj';

  @override
  String get noTransactionsYet => 'Brak transakcji';

  @override
  String get transactionOptions => 'Opcje transakcji';

  @override
  String get edit => 'Edytuj';

  @override
  String get delete => 'Usuń';

  @override
  String get confirmDelete => 'Usuń transakcję';

  @override
  String get confirmDeleteMessage =>
      'Czy na pewno chcesz usunąć tę transakcję?';

  @override
  String get cancel => 'Anuluj';

  @override
  String get noDescriptionTitle => 'Brak opisu';

  @override
  String get noDescriptionMessage =>
      'Czy na pewno chcesz dodać transakcję bez opisu?';

  @override
  String get transactionDeleted => 'Transakcja usunięta';

  @override
  String get transactionAdded => 'Transakcja dodana';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get appearance => 'Wygląd';

  @override
  String get theme => 'Motyw';

  @override
  String get themeLight => 'Jasny';

  @override
  String get themeDark => 'Ciemny';

  @override
  String get themeSystem => 'Systemowy';

  @override
  String get language => 'Język';

  @override
  String get currency => 'Waluta';

  @override
  String get currencyDollar => 'Dolar (\$)';

  @override
  String get currencyEuro => 'Euro (€)';

  @override
  String get currencyPound => 'Funt (£)';

  @override
  String get currencyZloty => 'Złoty (zł)';

  @override
  String get security => 'Bezpieczeństwo';

  @override
  String get pinCode => 'Kod PIN';

  @override
  String get biometricAuth => 'Uwierzytelnianie biometryczne';

  @override
  String get information => 'Informacje';

  @override
  String get about => 'O aplikacji';

  @override
  String get profile => 'Profil';

  @override
  String get developerRole => 'Programista aplikacji mobilnych';

  @override
  String get developerBio =>
      'Ponad 5 lat doświadczenia w tworzeniu natywnych aplikacji na Androida, obecnie skupiony na programowaniu wieloplatformowym z Flutterem. Bardzo zależy mi na czystej architekturze, łatwym w utrzymaniu kodzie oraz tworzeniu aplikacji, które są szybkie, dopracowane i naprawdę przydatne dla użytkowników.';

  @override
  String get skills => 'Umiejętności';

  @override
  String get getInTouch => 'Skontaktuj się';

  @override
  String get email => 'E-mail';

  @override
  String get appVersion => 'Money Tracker · v1.0.0';

  @override
  String get noTransactionsHint => 'Dotknij +, aby dodać pierwszą transakcję';

  @override
  String get editFeatureComingSoon => 'Funkcja edycji wkrótce dostępna';

  @override
  String get dismiss => 'Zamknij';

  @override
  String get languageNameEs => 'Hiszpański';

  @override
  String get languageNameEn => 'Angielski';

  @override
  String get languageNameFr => 'Francuski';

  @override
  String get languageNameDe => 'Niemiecki';

  @override
  String get languageNamePl => 'Polski';

  @override
  String get preferences => 'Preferencje';

  @override
  String get clearData => 'Wyczyść dane';

  @override
  String get confirmClearData => 'Uwaga';

  @override
  String get confirmClearDataMessage =>
      'Czy na pewno chcesz usunąć wszystkie dane?';

  @override
  String get dataCleared => 'Dane usunięte';

  @override
  String get pinCreateTitle => 'Utwórz PIN';

  @override
  String get pinCreateSubtitle =>
      'Ten PIN posłuży do odblokowania aplikacji i potwierdzania ważnych czynności';

  @override
  String get pinConfirmTitle => 'Potwierdź swój PIN';

  @override
  String get pinConfirmSubtitle =>
      'Wprowadź ponownie swój PIN, aby go potwierdzić';

  @override
  String get pinMismatch => 'Kody PIN się nie zgadzają. Spróbuj ponownie';

  @override
  String get pinVerifyTitle => 'Wprowadź swój PIN';

  @override
  String get pinIncorrect => 'Nieprawidłowy PIN. Spróbuj ponownie';

  @override
  String get pinEnabled => 'PIN włączony';

  @override
  String get pinDisabled => 'PIN wyłączony';
}
