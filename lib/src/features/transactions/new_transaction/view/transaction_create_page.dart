import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinttem_app/src/features/transactions/new_transaction/new_transaction.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

class TransactionCreatePage extends StatelessWidget {
  const TransactionCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Vinttem - New Transaction'), elevation: 4),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (context) {
            return NewTransactionBloc(
              vinttemRepository: context.read<VinttemRepository>(),
            );
          },
          child: const TransactionCreateForm(),
        ),
      ),
    );
  }
}
