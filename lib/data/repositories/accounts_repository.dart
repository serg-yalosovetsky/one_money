import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../db/local_db.dart';
import '../db/database_provider.dart';

part 'accounts_repository.g.dart';

@riverpod
class AccountsRepository extends _$AccountsRepository {
  @override
  Future<List<Account>> build() async {
    final db = ref.read(databaseProvider);
    return await db.select(db.accounts).get();
  }

  Future<void> addAccount(AccountsCompanion account) async {
    final db = ref.read(databaseProvider);
    await db.into(db.accounts).insert(account);
    ref.invalidateSelf();
  }

  Future<void> updateAccount(AccountsCompanion account) async {
    final db = ref.read(databaseProvider);
    await (db.update(db.accounts)..where((tbl) => tbl.id.equals(account.id.value)))
        .write(account);
    ref.invalidateSelf();
  }

  Future<void> deleteAccount(int id) async {
    final db = ref.read(databaseProvider);
    await (db.delete(db.accounts)..where((tbl) => tbl.id.equals(id))).go();
    ref.invalidateSelf();
  }

  Future<Account?> getAccountById(int id) async {
    final db = ref.read(databaseProvider);
    return await (db.select(db.accounts)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }
} 