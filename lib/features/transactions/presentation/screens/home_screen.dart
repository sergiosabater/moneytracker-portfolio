import 'package:flutter/material.dart';
import 'package:moneytracker/core/theme/app_colors.dart';
import 'package:moneytracker/features/transactions/presentation/widgets/add_transaction_dialog.dart';
import 'package:moneytracker/features/transactions/presentation/widgets/home_header.dart';
import 'package:moneytracker/features/transactions/presentation/widgets/transactions_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.headerGradient(Theme.of(context).brightness),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(children: [HomeHeader(), TransactionsList()]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return AddTransactionDialog();
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}