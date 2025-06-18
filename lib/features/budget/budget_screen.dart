import 'package:flutter/material.dart';
import '../../core/widgets/top_app_bar.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopAppBar(),
      body: Center(
        child: Text('Екран бюджету'),
      ),
    );
  }
}
