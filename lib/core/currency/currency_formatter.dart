import 'package:intl/intl.dart';
import 'package:moneytracker/core/currency/currency_option.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  /// Formats [amount] in [currency]'s style, for display purposes.
  ///
  /// Whole amounts omit their decimals entirely (5.00 -> "$5"), while
  /// any amount with a fractional part always shows both decimal
  /// digits (5.5 -> "$5.50", 5.55 -> "$5.55") — never a single
  /// trailing digit. This is decided by amount, not by a single
  /// pattern: [NumberFormat]'s optional-digit patterns (e.g. "0.0#")
  /// would trim 5.50 down to "5.5", which isn't the desired look.
  ///
  /// Set [showSign] to prefix positive amounts with "+" (negative
  /// amounts already carry their own "-" from the underlying number) —
  /// intended for individual transaction rows, where distinguishing
  /// income from expense at a glance matters. Left off (the default)
  /// for aggregate figures like the balance or the income/expense
  /// summary cards, where a leading sign would be redundant or
  /// misleading.
  ///
  /// Not for use as a live text-input display — see [formatForInput].
  static String format(
    CurrencyOption currency,
    double amount, {
    bool showSign = false,
  }) {
    final isWholeAmount = amount == amount.roundToDouble();
    final formatted = isWholeAmount
        ? _wholeFormatterFor(currency).format(amount)
        : _decimalFormatterFor(currency).format(amount);

    if (showSign && amount > 0) {
      return '+$formatted';
    }
    return formatted;
  }

  /// Formats [amount] always showing exactly 2 decimal digits, even for
  /// whole amounts (3.0 -> "$3.00"), unlike [format].
  ///
  /// This exists specifically for [CurrencyInputFormatter], which
  /// reconstructs how many digits the user has typed by reading them
  /// back out of the currently displayed text. [format]'s whole-amount
  /// trimming is lossy by design (that's what makes it look clean for
  /// display) — reusing it for live input would silently drop digits
  /// the moment the amount crossed a whole-number value while typing.
  /// Live editing needs a formatter that's always fully reversible;
  /// display doesn't.
  static String formatForInput(CurrencyOption currency, double amount) {
    return _decimalFormatterFor(currency).format(amount);
  }

  static NumberFormat _wholeFormatterFor(CurrencyOption currency) {
    final config = _configFor(currency);
    return NumberFormat.currency(
      locale: config.locale,
      symbol: config.symbol,
      decimalDigits: 0,
      customPattern: config.pattern,
    );
  }

  static NumberFormat _decimalFormatterFor(CurrencyOption currency) {
    final config = _configFor(currency);
    return NumberFormat.currency(
      locale: config.locale,
      symbol: config.symbol,
      decimalDigits: 2,
      customPattern: config.pattern,
    );
  }

  static _CurrencyConfig _configFor(CurrencyOption currency) {
    switch (currency) {
      case CurrencyOption.usd:
        return const _CurrencyConfig(
          locale: 'en_US',
          symbol: '\$',
          pattern: '¤#,##0.##',
        );
      case CurrencyOption.gbp:
        return const _CurrencyConfig(
          locale: 'en_GB',
          symbol: '£',
          pattern: '¤#,##0.##',
        );
      case CurrencyOption.eur:
        return const _CurrencyConfig(
          locale: 'de_DE',
          symbol: '€',
          pattern: '#,##0.## ¤',
        );
      case CurrencyOption.pln:
        return const _CurrencyConfig(
          locale: 'pl_PL',
          symbol: 'zł',
          pattern: '#,##0.## ¤',
        );
    }
  }
}

class _CurrencyConfig {
  final String locale;
  final String symbol;
  final String pattern;

  const _CurrencyConfig({
    required this.locale,
    required this.symbol,
    required this.pattern,
  });
}
