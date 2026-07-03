import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

/// Type of financial movement: money coming in or going out
enum TransactionType {
  income,
  expense,
}

/// Domain entity representing a single financial transaction.
/// This class is immutable and framework-agnostic (no DB or JSON logic here).
@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    int? id,
    required TransactionType type,
    required double amount,
    required String description,
    required DateTime dateTime,
  }) = _Transaction;
}