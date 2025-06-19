import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../db/local_db.dart';
import '../db/database_provider.dart';

part 'transactions_repository.g.dart';

@riverpod
class TransactionsRepository extends _$TransactionsRepository {
  @override
  Future<List<Transaction>> build() async {
    final db = ref.read(databaseProvider);
    return await db.select(db.transactions).get();
  }

  Future<void> addTransaction(TransactionsCompanion transaction) async {
    final db = ref.read(databaseProvider);
    await db.into(db.transactions).insert(transaction);
    ref.invalidateSelf();
  }

  Future<void> updateTransaction(TransactionsCompanion transaction) async {
    final db = ref.read(databaseProvider);
    await (db.update(db.transactions)..where((tbl) => tbl.id.equals(transaction.id.value)))
        .write(transaction);
    ref.invalidateSelf();
  }

  Future<void> deleteTransaction(int id) async {
    final db = ref.read(databaseProvider);
    await (db.delete(db.transactions)..where((tbl) => tbl.id.equals(id))).go();
    ref.invalidateSelf();
  }

  Future<Transaction?> getTransactionById(int id) async {
    final db = ref.read(databaseProvider);
    return await (db.select(db.transactions)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<Transaction>> getTransactionsByAccount(int accountId) async {
    final db = ref.read(databaseProvider);
    return await (db.select(db.transactions)..where((tbl) => tbl.accountId.equals(accountId)))
        .get();
  }

  Future<List<Transaction>> getTransactionsByCategory(int categoryId) async {
    final db = ref.read(databaseProvider);
    return await (db.select(db.transactions)..where((tbl) => tbl.categoryId.equals(categoryId)))
        .get();
  }
} 