import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:moneytracker/core/database/app_database.dart';
import 'package:moneytracker/features/transactions/domain/entities/transaction.dart';

class TransactionsLocalDatasource {
  final Database? _testDatabase;

  TransactionsLocalDatasource({Database? testDatabase})
      : _testDatabase = testDatabase;

  Future<Database> get _db async => _testDatabase ?? await AppDatabase.instance;

  Future<int> insertTransaction(Transaction transaction) async {
    final db = await _db;
    return db.insert('transactions', _toMap(transaction));
  }

  Future<List<Transaction>> getAllTransactions() async {
    final db = await _db;
    final result = await db.query('transactions', orderBy: 'dateTime DESC');
    return result.map(_fromMap).toList();
  }

  Future<int> deleteTransaction(int id) async {
    final db = await _db;
    return db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTransactions() async {
    final db = await _db;
    return db.delete('transactions');
  }

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