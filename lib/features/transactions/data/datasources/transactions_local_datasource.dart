import 'package:moneytracker/core/database/app_database.dart';
import 'package:moneytracker/features/transactions/domain/entities/transaction.dart';

/// Handles direct communication with the local SQLite database.
/// Responsible for mapping raw database rows to/from domain entities.
class TransactionsLocalDatasource {
  Future<int> insertTransaction(Transaction transaction) async {
    final db = await AppDatabase.instance;

    return db.insert('transactions', _toMap(transaction));
  }

  Future<List<Transaction>> getAllTransactions() async {
    final db = await AppDatabase.instance;

    final result = await db.query(
      'transactions',
      orderBy: 'dateTime DESC',
    );

    return result.map(_fromMap).toList();
  }

  Future<int> deleteTransaction(int id) async {
    final db = await AppDatabase.instance;

    return db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTransactions() async {
    final db = await AppDatabase.instance;

    return db.delete('transactions');
  }

  // --- Mapping helpers: database row <-> domain entity ---

  Map<String, dynamic> _toMap(Transaction transaction) {
    return {
      'type': transaction.type.toString(),
      'amount': transaction.amount,
      'description': transaction.description,
      'dateTime': transaction.dateTime.toIso8601String(),
    };
  }

  Transaction _fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int,
      type: map['type'] == 'TransactionType.income'
          ? TransactionType.income
          : TransactionType.expense,
      amount: map['amount'] as double,
      description: map['description'] as String,
      dateTime: DateTime.parse(map['dateTime'] as String),
    );
  }
}