part of 'transactions_list_bloc.dart';

abstract class TransactionsListEvent extends Equatable {
  const TransactionsListEvent();

  @override
  List<Object> get props => [];
}

class TransactionsListRequested extends TransactionsListEvent {
  const TransactionsListRequested();
}

class TransactionsListDeleteRequested extends TransactionsListEvent {
  const TransactionsListDeleteRequested({required this.transactionId});

  final int transactionId;

  @override
  List<Object> get props => [transactionId];
}
