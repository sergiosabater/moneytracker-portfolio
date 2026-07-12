import 'package:flutter/services.dart';
import 'package:moneytracker/core/currency/currency_formatter.dart';
import 'package:moneytracker/core/currency/currency_option.dart';

/// A [TextInputFormatter] that turns raw digit typing into a live,
/// currency-correct amount, reusing [CurrencyFormatter] as the single
/// source of truth for how an amount is displayed — the same formatting
/// logic used everywhere else in the app (Home, transaction list), so the
/// input field can never drift out of sync with how amounts are shown
/// elsewhere.
///
/// Digits are interpreted right-to-left, like a typical point-of-sale
/// amount field: typing "1", "2", "3" produces 0.01 -> 0.12 -> 1.23.
/// Edits that would push the integer part beyond [maxIntegerDigits] are
/// rejected outright (the field simply doesn't accept the keystroke).
class CurrencyInputFormatter extends TextInputFormatter {
  final CurrencyOption currency;
  final ValueChanged<double> onValueChanged;
  final int maxIntegerDigits;

  CurrencyInputFormatter({
    required this.currency,
    required this.onValueChanged,
    this.maxIntegerDigits = 6,
  });

  static String _digitsOf(String text) =>
      text.replaceAll(RegExp(r'[^0-9]'), '');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final oldDigits = _digitsOf(oldValue.text);
    final rawNewDigits = _digitsOf(newValue.text);

    String digitsOnly;
    if (newValue.text.length < oldValue.text.length &&
        rawNewDigits.length == oldDigits.length) {
      // The user deleted a character, but it wasn't a digit — for
      // suffix-symbol currencies (e.g. "1.234,56 €"), backspacing at the
      // end removes the trailing symbol or the space before it, not a
      // digit. Without this branch, re-stripping newValue.text would
      // yield the exact same digits as before, making backspace appear
      // to do nothing. We treat any deletion as "remove the last digit",
      // matching what the user actually intends regardless of which
      // decorative character Flutter happened to remove.
      digitsOnly =
          oldDigits.isEmpty ? '' : oldDigits.substring(0, oldDigits.length - 1);
    } else {
      digitsOnly = rawNewDigits;
    }

    if (digitsOnly.isEmpty) {
      onValueChanged(0);
      return TextEditingValue.empty;
    }

    // The last 2 digits are always the decimals; anything before that is
    // the integer part.
    final integerDigitsCount =
        digitsOnly.length > 2 ? digitsOnly.length - 2 : 0;
    if (integerDigitsCount > maxIntegerDigits) {
      return oldValue;
    }

    final rawCents = int.parse(digitsOnly);
    final decimalValue = rawCents / 100;
    final formatted = CurrencyFormatter.format(currency, decimalValue);

    onValueChanged(decimalValue);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}