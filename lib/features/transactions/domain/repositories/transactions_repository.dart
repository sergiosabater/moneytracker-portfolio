import 'package:moneytracker/features/transactions/domain/entities/transaction.dart';

/// Abstract contract for transaction persistence.
/// The domain and presentation layers depend only on this interface,
/// never on the concrete data source (SQLite, API, etc.).
abstract class TransactionsRepository {
  Future<List<Transaction>> getAllTransactions();

  Future<int> insertTransaction(Transaction transaction);

  Future<int> deleteTransaction(int id);

  Future<int> deleteAllTransactions();
}
