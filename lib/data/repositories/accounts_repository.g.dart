// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountsRepositoryHash() =>
    r'c38179504f5e574613d03154df95693be88e54dd';

/// See also [AccountsRepository].
@ProviderFor(AccountsRepository)
final accountsRepositoryProvider =
    AutoDisposeAsyncNotifierProvider<
      AccountsRepository,
      List<Account>
    >.internal(
      AccountsRepository.new,
      name: r'accountsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$accountsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AccountsRepository = AutoDisposeAsyncNotifier<List<Account>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
