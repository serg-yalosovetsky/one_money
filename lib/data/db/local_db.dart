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
    final dir  = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'money.db'));
    return NativeDatabase(file, logStatements: true);
  });
}

@DriftDatabase(tables: [Accounts, Categories, Transactions])
class LocalDb extends _$LocalDb {
  LocalDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}