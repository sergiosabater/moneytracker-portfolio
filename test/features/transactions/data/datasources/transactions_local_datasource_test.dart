import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' hide Transaction;
import 'package:moneytracker/features/transactions/data/datasources/transactions_local_datasource.dart';
import 'package:moneytracker/features/transactions/domain/entities/transaction.dart';

void main() {
  late Database db;
  late TransactionsLocalDatasource datasource;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = await databaseFactory.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE transactions (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              type TEXT NOT NULL,
              amount REAL NOT NULL,
              description TEXT NOT NULL,
              dateTime TEXT NOT NULL
            )
          ''');
        },
      ),
    );
    datasource = TransactionsLocalDatasource(testDatabase: db);
  });

  tearDown(() async {
    await db.close();
  });

  final testTransaction = Transaction(
    type: TransactionType.expense,
    amount: 42.75,
    description: 'Gasolina',
    dateTime: DateTime(2026, 8, 5),
  );

  test('insertTransaction guarda la transacción y devuelve un id válido', () async {
    final id = await datasource.insertTransaction(testTransaction);

    expect(id, greaterThan(0));
  });

  test('getAllTransactions devuelve las transacciones insertadas ordenadas por fecha desc', () async {
    final older = testTransaction.copyWith(
      description: 'Antigua',
      dateTime: DateTime(2026, 1, 1),
    );
    final newer = testTransaction.copyWith(
      description: 'Reciente',
      dateTime: DateTime(2026, 8, 5),
    );

    await datasource.insertTransaction(older);
    await datasource.insertTransaction(newer);

    final result = await datasource.getAllTransactions();

    expect(result.length, 2);
    expect(result.first.description, 'Reciente');
    expect(result.last.description, 'Antigua');
  });

  test('deleteTransaction elimina solo la transacción indicada', () async {
    final id1 = await datasource.insertTransaction(testTransaction);
    await datasource.insertTransaction(
      testTransaction.copyWith(description: 'Otra'),
    );

    await datasource.deleteTransaction(id1);
    final result = await datasource.getAllTransactions();

    expect(result.length, 1);
    expect(result.first.description, 'Otra');
  });

  test('deleteAllTransactions vacía la tabla', () async {
    await datasource.insertTransaction(testTransaction);
    await datasource.insertTransaction(
      testTransaction.copyWith(description: 'Otra'),
    );

    await datasource.deleteAllTransactions();
    final result = await datasource.getAllTransactions();

    expect(result, isEmpty);
  });

  test('income y expense se mapean correctamente ida y vuelta', () async {
    final income = testTransaction.copyWith(type: TransactionType.income);
    await datasource.insertTransaction(income);

    final result = await datasource.getAllTransactions();

    expect(result.first.type, TransactionType.income);
  });
}