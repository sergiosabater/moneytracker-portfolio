import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:path/path.dart';
import 'package:moneytracker/features/transactions/domain/entities/transaction.dart';

/// Handles direct communication with the local SQLite database.
/// Responsible for mapping raw database rows to/from domain entities.
class TransactionsLocalDatasource {
  // Singleton pattern
  static final TransactionsLocalDatasource instance =
      TransactionsLocalDatasource._init();
  static Database? _database;

  TransactionsLocalDatasource._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('transactions.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        description TEXT NOT NULL,
        dateTime TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertTransaction(Transaction transaction) async {
    final db = await instance.database;

    return await db.insert('transactions', _toMap(transaction));
  }

  Future<List<Transaction>> getAllTransactions() async {
    final db = await instance.database;

    final result = await db.query(
      'transactions',
      orderBy: 'dateTime DESC',
    );

    return result.map(_fromMap).toList();
  }

  Future<int> deleteTransaction(int id) async {
    final db = await instance.database;

    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTransactions() async {
    final db = await instance.database;

    return await db.delete('transactions');
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