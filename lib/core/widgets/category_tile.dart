import 'package:flutter/material.dart';
import '../../models/category_item.dart';

class CategoryTile extends StatelessWidget {
  final CategoryItem item;
  const CategoryTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,   // ⬅️ ДОДАНО
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: item.color.withOpacity(.15),
          child: Icon(item.icon, color: item.color, size: 28),
        ),
        const SizedBox(height: 4),                   // трохи менший відступ
        Text(item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11)),   // чутки менший шрифт
        const SizedBox(height: 2),
        const Text('0 ₴',
            style: TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}