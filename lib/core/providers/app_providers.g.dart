// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalBalanceHash() => r'a0de2b4ff6e93d763f33c3a11f1b4356ce75efa9';

/// See also [totalBalance].
@ProviderFor(totalBalance)
final totalBalanceProvider = AutoDisposeFutureProvider<double>.internal(
  totalBalance,
  name: r'totalBalanceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalBalanceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalBalanceRef = AutoDisposeFutureProviderRef<double>;
String _$selectedAccountBalanceHash() =>
    r'81f4704a501a532b5734d10970bb2d1411442100';

/// See also [selectedAccountBalance].
@ProviderFor(selectedAccountBalance)
final selectedAccountBalanceProvider =
    AutoDisposeFutureProvider<double>.internal(
      selectedAccountBalance,
      name: r'selectedAccountBalanceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedAccountBalanceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectedAccountBalanceRef = AutoDisposeFutureProviderRef<double>;
String _$transactionStatsHash() => r'288e4db5d2d66e9b602d7d0ba46677f4e06760f8';

/// See also [transactionStats].
@ProviderFor(transactionStats)
final transactionStatsProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
      transactionStats,
      name: r'transactionStatsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionStatsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransactionStatsRef =
    AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$selectedAccountHash() => r'453ce9a7dc5127a1994e87a48cb10c5e309dddcd';

/// See also [SelectedAccount].
@ProviderFor(SelectedAccount)
final selectedAccountProvider =
    AutoDisposeNotifierProvider<SelectedAccount, int?>.internal(
      SelectedAccount.new,
      name: r'selectedAccountProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedAccountHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedAccount = AutoDisposeNotifier<int?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
