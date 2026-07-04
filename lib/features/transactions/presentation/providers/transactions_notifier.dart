import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:moneytracker/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:moneytracker/features/transactions/domain/entities/transaction.dart';
import 'package:moneytracker/features/transactions/domain/repositories/transactions_repository.dart';

part 'transactions_notifier.g.dart';

/// Provides the concrete [TransactionsRepository] implementation to the rest
/// of the app. If the data source ever changes (e.g. to a remote API),
/// only this provider needs to be updated.
@riverpod
TransactionsRepository transactionsRepository(Ref ref) {
  return TransactionsRepositoryImpl();
}

/// Holds and manages the list of transactions.
/// Loading/data/error states are handled automatically through [AsyncValue],
/// so no manual `isLoading` flag is needed (unlike the old ChangeNotifier).
@riverpod
class TransactionsNotifier extends _$TransactionsNotifier {
  @override
  Future<List<Transaction>> build() async {
    final repository = ref.watch(transactionsRepositoryProvider);
    return repository.getAllTransactions();
  }

  /// Adds a new transaction and refreshes the list.
  Future<void> addTransaction(Transaction transaction) async {
    final repository = ref.read(transactionsRepositoryProvider);
    await repository.insertTransaction(transaction);
    ref.invalidateSelf();
    await future;
  }

  /// Deletes a transaction by id and refreshes the list.
  Future<void> deleteTransaction(int id) async {
    final repository = ref.read(transactionsRepositoryProvider);
    await repository.deleteTransaction(id);
    ref.invalidateSelf();
    await future;
  }

  /// Deletes every transaction and refreshes the list.
  Future<void> clearTransactions() async {
    final repository = ref.read(transactionsRepositoryProvider);
    await repository.deleteAllTransactions();
    ref.invalidateSelf();
    await future;
  }
}

/// Total sum of all income transactions.
@riverpod
double totalIncomes(Ref ref) {
  final transactions = ref.watch(transactionsNotifierProvider).value ?? [];
  return transactions
      .where((transaction) => transaction.type == TransactionType.income)
      .map((transaction) => transaction.amount)
      .fold(0, (a, b) => a + b);
}

/// Total sum of all expense transactions.
@riverpod
double totalExpenses(Ref ref) {
  final transactions = ref.watch(transactionsNotifierProvider).value ?? [];
  return transactions
      .where((transaction) => transaction.type == TransactionType.expense)
      .map((transaction) => transaction.amount)
      .fold(0, (a, b) => a + b);
}

/// Current balance: incomes + expenses (expenses are stored as negative
/// amounts, same convention as the original app).
@riverpod
double balance(Ref ref) {
  return ref.watch(totalIncomesProvider) + ref.watch(totalExpensesProvider);
}