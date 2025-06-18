// lib/features/categories/categories_screen.dart
import 'package:flutter/material.dart';
import '../../core/widgets/top_app_bar.dart';
import '../../models/category_item.dart';
import '../../core/widgets/category_tile.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  final List<CategoryItem> categories = [
    CategoryItem('Продукти', Icons.shopping_basket, Colors.lightBlue),
    CategoryItem('Ресторація', Icons.restaurant, Colors.indigo),
    CategoryItem('Дозвілля', Icons.theaters, Colors.pinkAccent),
    CategoryItem('Транспорт', Icons.directions_bus, Colors.orange),
    CategoryItem('Здоров\'я', Icons.volunteer_activism, Colors.green),
    CategoryItem('Сім\'я', Icons.sentiment_satisfied, Colors.purpleAccent),
    CategoryItem('Подарунки', Icons.card_giftcard, Colors.redAccent),
    CategoryItem('Покупки', Icons.shopping_bag, Colors.brown),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // універсальний top-bar
      appBar: const TopAppBar(
        showMonth: true,
        monthText: 'ЧЕРВЕНЬ 2025',
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          // ---- сітка категорій ----
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                return GestureDetector(
                  onTap: () => _openTransactionInput(context, cat),
                  child: CategoryTile(item: cat),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /* ------------------------------------------------------------------ */
  /*                 MODAL: введення транзакції                         */
  /* ------------------------------------------------------------------ */

  void _openTransactionInput(BuildContext context, CategoryItem category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TransactionInputModal(category: category),
    );
  }
}

/* ==================================================================== */
/*                     Вміст модального вікна                           */
/* ==================================================================== */

class _TransactionInputModal extends StatefulWidget {
  final CategoryItem category;
  const _TransactionInputModal({required this.category});

  @override
  State<_TransactionInputModal> createState() => _TransactionInputModalState();
}

class _TransactionInputModalState extends State<_TransactionInputModal> {
  final TextEditingController _noteCtrl = TextEditingController();
  String _amount = '0';

  void _onKeyboardTap(String v) {
    setState(() {
      if (v == '×') {
        _amount = '0';
      } else if (v == '✓') {
        // TODO: зберегти транзакцію
        Navigator.pop(context);
      } else {
        if (_amount == '0') _amount = '';
        _amount += v;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cat = widget.category;
    final calculatorLabels = [
      '×', '7', '8', '9',
      '−', '4', '5', '6',
      '+', '1', '2', '3',
      '₴', '0', ',', '✓',
    ];

    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      maxChildSize: 0.95,
      minChildSize: 0.6,
      builder: (_, scrollCtrl) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- рахунок -> категорія ---
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'З рахунку\nКарта',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cat.color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text('До категорії',
                            style: TextStyle(color: Colors.white70, fontSize: 12)),
                        Text(cat.title,
                            style: const TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- сума ---
            Center(
              child: Text(
                'Витрата\n$_amount ₴',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: cat.color,
                ),
              ),
            ),
            const SizedBox(height: 14),

            // --- нотатка ---
            TextField(
              controller: _noteCtrl,
              decoration: const InputDecoration(
                hintText: 'Нотатки…',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),

            // --- калькулятор ---
            Expanded(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.1,
                children: List.generate(calculatorLabels.length, (i) {
                  final label = calculatorLabels[i];
                  final isAction = (label == '×' || label == '✓');
                  final isEqual = label == '✓';
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isEqual
                          ? cat.color
                          : isAction
                          ? Colors.grey.shade300
                          : Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _onKeyboardTap(label),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 20,
                        color: isEqual ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                }),
              ),
            ),

            // --- дата ---
            Center(
              child: Text(
                'Сьогодні, 19 черв. 2025 р.',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
