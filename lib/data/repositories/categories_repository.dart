import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../db/local_db.dart';
import '../db/database_provider.dart';

part 'categories_repository.g.dart';

@riverpod
class CategoriesRepository extends _$CategoriesRepository {
  @override
  Future<List<Category>> build() async {
    final db = ref.read(databaseProvider);
    return await db.select(db.categories).get();
  }

  Future<void> addCategory(CategoriesCompanion category) async {
    final db = ref.read(databaseProvider);
    await db.into(db.categories).insert(category);
    ref.invalidateSelf();
  }

  Future<void> updateCategory(CategoriesCompanion category) async {
    final db = ref.read(databaseProvider);
    await (db.update(db.categories)..where((tbl) => tbl.id.equals(category.id.value)))
        .write(category);
    ref.invalidateSelf();
  }

  Future<void> deleteCategory(int id) async {
    final db = ref.read(databaseProvider);
    await (db.delete(db.categories)..where((tbl) => tbl.id.equals(id))).go();
    ref.invalidateSelf();
  }

  Future<Category?> getCategoryById(int id) async {
    final db = ref.read(databaseProvider);
    return await (db.select(db.categories)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }
} 