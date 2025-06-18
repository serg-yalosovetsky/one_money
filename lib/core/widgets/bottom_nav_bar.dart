import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Рахунки'),
        BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Категорії'),
        BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Операції'),
        BottomNavigationBarItem(icon: Icon(Icons.speed), label: 'Бюджет'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Огляд'),
      ],
    );
  }
}
