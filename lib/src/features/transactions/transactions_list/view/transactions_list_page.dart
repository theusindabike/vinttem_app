import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinttem_app/src/features/transactions/transaction.dart';
import 'package:vinttem_repository/vinttem_repository.dart'
    as vinttem_repository;

class TransactionsListPage extends StatelessWidget {
  const TransactionsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TransactionsListView();
  }
}

class TransactionsListView extends StatelessWidget {
  const TransactionsListView({super.key});

  @override
  Widget build(BuildContext context) {
    _fetchTransactions(context);

    return RefreshIndicator(
      onRefresh: () async {
        _fetchTransactions(context);
      },
      child: BlocBuilder<TransactionsListBloc, TransactionsListState>(
        builder: (context, state) {
          return switch (state.status) {
            TransactionsListStatus.initial ||
            TransactionsListStatus.loading =>
              const Center(child: CupertinoActivityIndicator()),
            TransactionsListStatus.success => TrasactionsListView(state: state),
            TransactionsListStatus.failure =>
              const Center(child: Text('No transactions made')),
          };
        },
      ),
    );
  }

  void _fetchTransactions(BuildContext context) => context
      .read<TransactionsListBloc>()
      .add(const TransactionsListRequested());
}

class TrasactionsListView extends StatelessWidget {
  const TrasactionsListView({
    super.key,
    required this.state,
  });

  final TransactionsListState state;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        for (final t in state.transactions)
          Dismissible(
            key: Key('dismissibleTransactionCard_${t.id}'),
            background: Container(
              color: Colors.red,
            ),
            direction: DismissDirection.endToStart,
            child: Card(
              margin: const EdgeInsets.only(top: 10),
              child: TransactionListTile(transaction: t),
            ),
          )
      ],
    );
  }
}

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    super.key,
    required this.transaction,
  });

  final vinttem_repository.Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key('transactionCard_${transaction.id}'),
      leading: const Icon(Icons.shopping_bag),
      title: Text(transaction.category.description),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Type: ${transaction.type.description}'),
          Text(
            'R\$ ${transaction.value.toString().replaceAll('.', ',')}',
          ),
        ],
      ),
      trailing: const Icon(Icons.more_vert),
    );
  }
}
