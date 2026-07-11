import 'package:intl/intl.dart';
import 'package:moneytracker/core/currency/currency_option.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static String format(CurrencyOption currency, double amount) {
    return _formatterFor(currency).format(amount);
  }

  static NumberFormat _formatterFor(CurrencyOption currency) {
    switch (currency) {
      case CurrencyOption.usd:
        return NumberFormat.currency(
          locale: 'en_US',
          symbol: '\$',
          decimalDigits: 2,
          customPattern: '¤#,##0.00',
        );
      case CurrencyOption.gbp:
        return NumberFormat.currency(
          locale: 'en_GB',
          symbol: '£',
          decimalDigits: 2,
          customPattern: '¤#,##0.00',
        );
      case CurrencyOption.eur:
        return NumberFormat.currency(
          locale: 'de_DE',
          symbol: '€',
          decimalDigits: 2,
          customPattern: '#,##0.00 ¤',
        );
      case CurrencyOption.pln:
        return NumberFormat.currency(
          locale: 'pl_PL',
          symbol: 'zł',
          decimalDigits: 2,
          customPattern: '#,##0.00 ¤',
        );
    }
  }
}