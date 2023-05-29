part of 'transactions_list_bloc.dart';

abstract class TransactionsListEvent extends Equatable {
  const TransactionsListEvent();

  @override
  List<Object> get props => [];
}

class TransactionsListRequested extends TransactionsListEvent {
  const TransactionsListRequested();
}
