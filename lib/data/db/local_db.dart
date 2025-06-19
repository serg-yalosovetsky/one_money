import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'local_db.g.dart';


/* ───────────────────  TABLES  ─────────────────── */

class Accounts extends Table {
  IntColumn  get id      => integer().autoIncrement()();
  TextColumn get name    => text()();
  RealColumn get balance => real().withDefault(const Constant(0))();
}

class Categories extends Table {
  IntColumn  get id    => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn  get color => integer()();                       // збережемо ARGB
}

class Transactions extends Table {
  IntColumn    get id          => integer().autoIncrement()();
  IntColumn    get accountId   =>
      integer().references(Accounts, #id)();
  IntColumn    get categoryId  =>
      integer().references(Categories, #id)();
  RealColumn   get amount      => real()();
  DateTimeColumn get date      => dateTime().withDefault(currentDate)();
  TextColumn   get note        => text().nullable()();
}

/* ───────────────────  DB CLASS  ─────────────────── */

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    String dbPath;
    if (Platform.isWindows) {
      // Зберігаємо базу поруч з .exe (у робочій директорії)
      dbPath = p.join(Directory.current.path, 'money.sqlite');
    } else {
      // Для мобільних платформ
      final dir = await getApplicationDocumentsDirectory();
      dbPath = p.join(dir.path, 'money.sqlite');
    }
    final file = File(dbPath);

    // Переконайтесь, що директорія існує (актуально для мобільних)
    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Accounts, Categories, Transactions])
class LocalDb extends _$LocalDb {
  LocalDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;
  
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        // Create all tables on database creation
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // Handle future migrations here
      },
      beforeOpen: (details) async {
        // Optionally verify or initialize data before opening
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
  
  // Helper method to ensure database is ready
  Future<void> ensureInitialized() async {
    // This will trigger table creation if needed
    await transaction(() async {
      // Query any table to trigger initialization
      await customSelect('SELECT 1').get();
    });
  }
}