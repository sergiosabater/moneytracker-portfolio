import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moneytracker/features/transactions/data/datasources/transactions_local_datasource.dart';
import 'package:moneytracker/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:moneytracker/features/transactions/domain/entities/transaction.dart';

class MockTransactionsLocalDatasource extends Mock
    implements TransactionsLocalDatasource {}

void main() {
  late MockTransactionsLocalDatasource mockDatasource;
  late TransactionsRepositoryImpl repository;

  final testTransaction = Transaction(
    type: TransactionType.expense,
    amount: 25.5,
    description: 'Compra supermercado',
    dateTime: DateTime(2026, 8, 1),
  );

  setUp(() {
    mockDatasource = MockTransactionsLocalDatasource();
    repository = TransactionsRepositoryImpl(localDatasource: mockDatasource);
  });

  group('getAllTransactions', () {
    test('delega en el datasource y devuelve la lista', () async {
      when(() => mockDatasource.getAllTransactions())
          .thenAnswer((_) async => [testTransaction]);

      final result = await repository.getAllTransactions();

      expect(result, [testTransaction]);
      verify(() => mockDatasource.getAllTransactions()).called(1);
    });
  });

  group('insertTransaction', () {
    test('pasa la transacción correcta al datasource y devuelve el id', () async {
      when(() => mockDatasource.insertTransaction(testTransaction))
          .thenAnswer((_) async => 1);

      final result = await repository.insertTransaction(testTransaction);

      expect(result, 1);
      verify(() => mockDatasource.insertTransaction(testTransaction)).called(1);
    });
  });

  group('deleteTransaction', () {
    test('pasa el id correcto al datasource', () async {
      when(() => mockDatasource.deleteTransaction(1))
          .thenAnswer((_) async => 1);

      final result = await repository.deleteTransaction(1);

      expect(result, 1);
      verify(() => mockDatasource.deleteTransaction(1)).called(1);
    });
  });

  group('deleteAllTransactions', () {
    test('delega en el datasource', () async {
      when(() => mockDatasource.deleteAllTransactions())
          .thenAnswer((_) async => 3);

      final result = await repository.deleteAllTransactions();

      expect(result, 3);
      verify(() => mockDatasource.deleteAllTransactions()).called(1);
    });
  });
}