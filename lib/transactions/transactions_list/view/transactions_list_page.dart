import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinttem_app/transactions/transaction.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

class TransactionsListPage extends StatelessWidget {
  const TransactionsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionsListBloc(
        transactionRepository: context.read<VinttemRepository>(),
      )..add(const TransactionsListSubscriptionRequested()),
      child: const TransactionsListView(),
    );
  }
}

class TransactionsListView extends StatelessWidget {
  const TransactionsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TransactionsListBloc, TransactionsListState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == TransactionsListStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(content: Text('deu ruim')));
            }
          },
        )
      ],
      child: BlocBuilder<TransactionsListBloc, TransactionsListState>(
        builder: (context, state) {
          if (state.transactions.isEmpty) {
            if (state.status == TransactionsListStatus.loading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state.status != TransactionsListStatus.success) {
              return const Center(child: CupertinoActivityIndicator());
            } else {
              return const Center(child: Text('zero transações por aqui'));
            }
          }

          return ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              for (final t in state.transactions)
                Card(
                  margin: const EdgeInsets.only(top: 10),
                  child: ListTile(
                    key: Key('transactionCard_${t.id}'),
                    leading: const Icon(Icons.shopping_bag),
                    title: Text(t.category.description),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Type: ${t.type.description}'),
                        Text(
                          'R\$ ${t.value.toString().replaceAll('.', ',')}',
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.more_vert),
                    onTap: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(content: Text('working in progress')),
                        );
                    },
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
