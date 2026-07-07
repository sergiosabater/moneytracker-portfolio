import 'package:moneytracker/features/transactions/data/datasources/transactions_local_datasource.dart';
import 'package:moneytracker/features/transactions/domain/entities/transaction.dart';
import 'package:moneytracker/features/transactions/domain/repositories/transactions_repository.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  final TransactionsLocalDatasource _localDatasource;

  TransactionsRepositoryImpl({
    TransactionsLocalDatasource? localDatasource,
  }) : _localDatasource = localDatasource ?? TransactionsLocalDatasource();

  @override
  Future<List<Transaction>> getAllTransactions() {
    return _localDatasource.getAllTransactions();
  }

  @override
  Future<int> insertTransaction(Transaction transaction) {
    return _localDatasource.insertTransaction(transaction);
  }

  @override
  Future<int> deleteTransaction(int id) {
    return _localDatasource.deleteTransaction(id);
  }

  @override
  Future<int> deleteAllTransactions() {
    return _localDatasource.deleteAllTransactions();
  }
}