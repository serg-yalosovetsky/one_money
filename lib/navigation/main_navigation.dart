import 'package:flutter/material.dart';
import '../features/accounts/accounts_screen.dart';
import '../features/categories/categories_screen.dart';
import '../features/transactions/transactions_screen.dart';
import '../features/budget/budget_screen.dart';
import '../features/overview/overview_screen.dart';
import '../core/widgets/bottom_nav_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 1;

  final List<Widget> _screens =  [
    AccountsScreen(),
    CategoriesScreen(),
    TransactionsScreen(),
    BudgetScreen(),
    OverviewScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
