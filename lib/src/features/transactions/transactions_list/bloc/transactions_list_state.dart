part of 'transactions_list_bloc.dart';

enum TransactionsListStatus { initial, loading, success, failure }

class TransactionsListState extends Equatable {
  const TransactionsListState({
    this.status = TransactionsListStatus.initial,
    this.transactions = const [],
  });

  final TransactionsListStatus status;
  final List<Transaction> transactions;

  @override
  List<Object> get props => [
        status,
        transactions,
      ];
  TransactionsListState copyWith({
    TransactionsListStatus? status,
    List<Transaction>? transactions,
    int? transactionIdToDelete,
  }) {
    return TransactionsListState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
    );
  }
}
