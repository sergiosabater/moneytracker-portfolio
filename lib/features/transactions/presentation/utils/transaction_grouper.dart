import 'package:moneytracker/features/transactions/domain/entities/transaction.dart';

/// A consecutive run of transactions sharing the same display label
/// (e.g. all transactions from "Today").
class TransactionSection {
  final String label;
  final List<Transaction> transactions;

  TransactionSection({required this.label, required this.transactions});
}

/// Groups a list of transactions into date-based sections for display,
/// e.g. "Today", "Yesterday", "Mon, Mar 8" — the labels themselves are
/// resolved by the caller via [TransactionSection.groupByDate]'s
/// `labelFor` callback, keeping this class free of any formatting or
/// localization concerns.
class TransactionGrouper {
  TransactionGrouper._();

  /// Groups [transactions] into sections, calling [labelFor] once per
  /// transaction to determine which section it belongs to. Assumes
  /// [transactions] are already sorted newest-first (as returned by
  /// [TransactionsRepository]) and preserves that order — a new section
  /// only starts when the label actually changes from the previous
  /// transaction's.
  static List<TransactionSection> groupByDate(
    List<Transaction> transactions, {
    required String Function(DateTime date) labelFor,
  }) {
    final sections = <TransactionSection>[];

    for (final transaction in transactions) {
      final label = labelFor(transaction.dateTime);

      if (sections.isNotEmpty && sections.last.label == label) {
        sections.last.transactions.add(transaction);
      } else {
        sections.add(
          TransactionSection(label: label, transactions: [transaction]),
        );
      }
    }

    return sections;
  }
}
