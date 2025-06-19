# One Money - Flutter Finance App

Мобільний додаток для управління особистими фінансами, побудований з використанням Flutter, Riverpod 2 та Drift.

## Технології

- **Flutter** - UI фреймворк
- **Riverpod 2** - State management
- **Drift** - Local database (SQLite)
- **SQLite** - Local storage

## Особливості

- ✅ Управління рахунками
- ✅ Категорії витрат
- ✅ Транзакції (доходи/витрати)
- ✅ Статистика та аналітика
- ✅ Локальне зберігання даних
- ✅ Реактивний UI з Riverpod

## Запуск додатку

### Windows
1. Очистіть попередні збірки:
   ```bash
   flutter clean
   ```
2. Оновіть залежності:
   ```bash
   flutter pub get
   ```
3. Згенеруйте код:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. Запустіть додаток:
   ```bash
   flutter run -d windows
   ```

### Android
1. Підключіть пристрій або запустіть емулятор
2. Виконайте:
   ```bash
   flutter run -d android
   ```

### iOS (тільки на macOS)
1. Відкрийте симулятор iOS:
   ```bash
   open -a Simulator
   ```
2. Запустіть додаток:
   ```bash
   flutter run -d ios
   ```

### Web
1. Запустіть Chrome:
   ```bash
   flutter run -d chrome
   ```

## Структура проекту

```
lib/
├── core/
│   ├── providers/     # Riverpod провайдери
│   └── widgets/       # Спільні віджети
├── data/
│   ├── db/           # Drift база даних
│   ├── models/       # Моделі даних
│   └── repositories/ # Репозиторії
├── domain/
│   ├── entities/     # Бізнес-сутності
│   ├── repositories/ # Інтерфейси репозиторіїв
│   └── usecases/     # Use cases
└── features/         # Екрани додатку
```

## Встановлення

1. Клонуйте репозиторій
2. Встановіть залежності:
   ```bash
   flutter pub get
   ```
3. Згенеруйте код:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. Запустіть додаток:
   ```bash
   flutter run
   ```

## Використання Riverpod 2

### Провайдери

```dart
// Провайдер для бази даних
final databaseProvider = Provider<LocalDb>((ref) {
  return LocalDb();
});

// Провайдер для репозиторію
@riverpod
class AccountsRepository extends _$AccountsRepository {
  @override
  Future<List<Account>> build() async {
    final db = ref.read(databaseProvider);
    return await db.select(db.accounts).get();
  }
}
```

### Використання в UI

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(accountsRepositoryProvider);
    
    return accountsAsync.when(
      data: (accounts) => ListView.builder(...),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
```

## Використання Drift

### Визначення таблиць

```dart
class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get balance => real().withDefault(const Constant(0))();
}
```

### Запити

```dart
// Отримання всіх рахунків
final accounts = await db.select(db.accounts).get();

// Додавання нового рахунку
await db.into(db.accounts).insert(
  AccountsCompanion.insert(name: 'Новий рахунок', balance: 1000.0)
);
```

## Розробка

### Генерація коду

Після зміни файлів з анотаціями Riverpod або Drift, запустіть:

```bash
dart run build_runner build
```

Для автоматичної генерації при змінах:

```bash
dart run build_runner watch
```

### Структура даних

- **Accounts** - Рахунки користувача
- **Categories** - Категорії витрат/доходів
- **Transactions** - Транзакції

## Ліцензія

MIT License
