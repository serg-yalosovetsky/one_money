import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local_db.dart';

// Database instance provider
final databaseProvider = Provider<LocalDb>((ref) {
  final db = LocalDb();
  
  ref.onDispose(() async {
    await db.close();
  });
  
  return db;
});

// Database initialization state provider
final databaseInitProvider = FutureProvider<void>((ref) async {
  final db = ref.watch(databaseProvider);
  await db.ensureInitialized();
}); 