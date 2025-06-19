import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'data/db/database_provider.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize path provider
  await getApplicationDocumentsDirectory();
  
  // Create ProviderContainer for initialization
  final container = ProviderContainer();
  
  // Initialize database
  try {
    // Access database to trigger initialization
    container.read(databaseProvider);
  } catch (e) {
    debugPrint('Database initialization error: $e');
  } finally {
    container.dispose();
  }
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
