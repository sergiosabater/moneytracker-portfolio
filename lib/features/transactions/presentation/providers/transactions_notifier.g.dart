// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionsRepositoryHash() =>
    r'8b301263467a5b1e785cfc2490e844b728bc0211';

/// Provides the concrete [TransactionsRepository] implementation to the rest
/// of the app. If the data source ever changes (e.g. to a remote API),
/// only this provider needs to be updated.
///
/// Copied from [transactionsRepository].
@ProviderFor(transactionsRepository)
final transactionsRepositoryProvider =
    AutoDisposeProvider<TransactionsRepository>.internal(
      transactionsRepository,
      name: r'transactionsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransactionsRepositoryRef =
    AutoDisposeProviderRef<TransactionsRepository>;
String _$totalIncomesHash() => r'64cd6be191b1b7ce1f9ee203899af2675e5ac161';

/// Total sum of all income transactions.
///
/// Copied from [totalIncomes].
@ProviderFor(totalIncomes)
final totalIncomesProvider = AutoDisposeProvider<double>.internal(
  totalIncomes,
  name: r'totalIncomesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalIncomesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalIncomesRef = AutoDisposeProviderRef<double>;
String _$totalExpensesHash() => r'ea8b716680bf8ba7a74b27785a574024bf35d171';

/// Total sum of all expense transactions.
///
/// Copied from [totalExpenses].
@ProviderFor(totalExpenses)
final totalExpensesProvider = AutoDisposeProvider<double>.internal(
  totalExpenses,
  name: r'totalExpensesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalExpensesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalExpensesRef = AutoDisposeProviderRef<double>;
String _$balanceHash() => r'd107c2047e30d4b60d0fdd544bb51848c0f4dd3a';

/// Current balance: incomes + expenses (expenses are stored as negative
/// amounts, same convention as the original app).
///
/// Copied from [balance].
@ProviderFor(balance)
final balanceProvider = AutoDisposeProvider<double>.internal(
  balance,
  name: r'balanceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$balanceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BalanceRef = AutoDisposeProviderRef<double>;
String _$transactionsNotifierHash() =>
    r'2e80a802d863d6375b6a05ac9e662387033ebe4c';

/// Holds and manages the list of transactions.
/// Loading/data/error states are handled automatically through [AsyncValue],
/// so no manual `isLoading` flag is needed (unlike the old ChangeNotifier).
///
/// Copied from [TransactionsNotifier].
@ProviderFor(TransactionsNotifier)
final transactionsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      TransactionsNotifier,
      List<Transaction>
    >.internal(
      TransactionsNotifier.new,
      name: r'transactionsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TransactionsNotifier = AutoDisposeAsyncNotifier<List<Transaction>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
