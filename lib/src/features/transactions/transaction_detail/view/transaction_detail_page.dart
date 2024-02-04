import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinttem_app/src/features/transactions/transaction_create/transaction_create.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Transaction detailed'), elevation: 4),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (context) {
            return TransactionCreateBloc(
              vinttemRepository: context.read<VinttemRepository>(),
            );
          },
          child: const TransactionCreateForm(),
        ),
      ),
    );
  }
}
