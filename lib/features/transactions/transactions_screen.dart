import 'package:flutter/material.dart';
import '../../core/widgets/top_app_bar.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopAppBar(),
      body: Center(
        child: Text('Екран операцій'),
      ),
    );
  }
}
