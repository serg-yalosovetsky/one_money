import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/accounts_usecases.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(accountsUseCasesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Рахунки'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddAccountDialog(context, ref),
          ),
        ],
      ),
      body: accountsAsync.when(
        data: (accounts) => accounts.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_balance_wallet, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('Немає рахунків', style: TextStyle(fontSize: 18, color: Colors.grey)),
                    SizedBox(height: 8),
                    Text('Додайте свій перший рахунок', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(Icons.account_balance_wallet, color: Colors.blue.shade700),
                      ),
                      title: Text(account.name),
                      subtitle: Text('Баланс: ${account.balance.toStringAsFixed(2)} ₴'),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                SizedBox(width: 8),
                                Text('Редагувати'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Видалити', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 'edit') {
                            _showEditAccountDialog(context, ref, account);
                          } else if (value == 'delete') {
                            _showDeleteAccountDialog(context, ref, account.id);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Помилка завантаження: $error'),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddAccountDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final balanceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Додати рахунок'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Назва рахунку'),
            ),
            TextField(
              controller: balanceController,
              decoration: const InputDecoration(labelText: 'Початковий баланс'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Скасувати'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                final balance = double.tryParse(balanceController.text) ?? 0.0;
                await ref.read(accountsUseCasesProvider.notifier).createAccount(
                  nameController.text,
                  balance,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Додати'),
          ),
        ],
      ),
    );
  }

  void _showEditAccountDialog(BuildContext context, WidgetRef ref, account) {
    final nameController = TextEditingController(text: account.name);
    final balanceController = TextEditingController(text: account.balance.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редагувати рахунок'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Назва рахунку'),
            ),
            TextField(
              controller: balanceController,
              decoration: const InputDecoration(labelText: 'Баланс'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Скасувати'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                final balance = double.tryParse(balanceController.text) ?? 0.0;
                await ref.read(accountsUseCasesProvider.notifier).updateAccount(
                  account.id,
                  nameController.text,
                  balance,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Зберегти'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, WidgetRef ref, int accountId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Видалити рахунок'),
        content: const Text('Ви впевнені, що хочете видалити цей рахунок?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Скасувати'),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref.read(accountsUseCasesProvider.notifier).deleteAccount(accountId);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Видалити', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}