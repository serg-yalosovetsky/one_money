import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/accounts_repository.dart';
import '../../data/db/local_db.dart';

part 'accounts_usecases.g.dart';

@riverpod
class AccountsUseCases extends _$AccountsUseCases {
  @override
  Future<List<Account>> build() async {
    return await ref.read(accountsRepositoryProvider.future);
  }

  Future<void> createAccount(String name, double balance) async {
    final repository = ref.read(accountsRepositoryProvider.notifier);
    await repository.addAccount(
      AccountsCompanion.insert(
        name: name,
        balance: Value(balance),
      ),
    );
  }

  Future<void> updateAccount(int id, String name, double balance) async {
    final repository = ref.read(accountsRepositoryProvider.notifier);
    await repository.updateAccount(
      AccountsCompanion(
        id: Value(id),
        name: Value(name),
        balance: Value(balance),
      ),
    );
  }

  Future<void> deleteAccount(int id) async {
    final repository = ref.read(accountsRepositoryProvider.notifier);
    await repository.deleteAccount(id);
  }

  Future<Account?> getAccount(int id) async {
    final repository = ref.read(accountsRepositoryProvider.notifier);
    return await repository.getAccountById(id);
  }
} 