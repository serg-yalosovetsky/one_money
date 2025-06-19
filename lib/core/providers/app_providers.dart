import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/accounts_repository.dart';
import '../../data/repositories/categories_repository.dart';
import '../../data/repositories/transactions_repository.dart';
import '../../domain/usecases/accounts_usecases.dart';

part 'app_providers.g.dart';

// Провайдер для текущего выбранного аккаунта
@riverpod
class SelectedAccount extends _$SelectedAccount {
  @override
  int? build() => null;

  void selectAccount(int accountId) {
    state = accountId;
  }

  void clearSelection() {
    state = null;
  }
}

// Провайдер для общего баланса всех аккаунтов
@riverpod
Future<double> totalBalance(Ref ref) async {
  final accounts = await ref.watch(accountsUseCasesProvider.future);
  double total = 0.0;
  for (final account in accounts) {
    total += account.balance;
  }
  return total;
}

// Провайдер для баланса выбранного аккаунта
@riverpod
Future<double> selectedAccountBalance(Ref ref) async {
  final selectedAccountId = ref.watch(selectedAccountProvider);
  if (selectedAccountId == null) return 0.0;
  
  final account = await ref.read(accountsUseCasesProvider.notifier).getAccount(selectedAccountId);
  return account?.balance ?? 0.0;
}

// Провайдер для статистики транзакций
@riverpod
Future<Map<String, dynamic>> transactionStats(Ref ref) async {
  final transactions = await ref.watch(transactionsRepositoryProvider.future);
  final accounts = await ref.watch(accountsRepositoryProvider.future);
  final categories = await ref.watch(categoriesRepositoryProvider.future);
  
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  
  for (final transaction in transactions) {
    if (transaction.amount > 0) {
      totalIncome += transaction.amount;
    } else {
      totalExpense += transaction.amount.abs();
    }
  }
  
  return {
    'totalIncome': totalIncome,
    'totalExpense': totalExpense,
    'netAmount': totalIncome - totalExpense,
    'transactionCount': transactions.length,
    'accountCount': accounts.length,
    'categoryCount': categories.length,
  };
} 