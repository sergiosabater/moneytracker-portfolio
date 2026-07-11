import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneytracker/core/currency/currency_formatter.dart';
import 'package:moneytracker/core/currency/currency_option.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final CurrencyOption currency;
  final ValueChanged<double> onValueChanged;
  final int maxIntegerDigits;

  CurrencyInputFormatter({
    required this.currency,
    required this.onValueChanged,
    this.maxIntegerDigits = 6,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

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