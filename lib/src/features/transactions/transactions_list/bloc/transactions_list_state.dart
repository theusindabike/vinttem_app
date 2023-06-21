part of 'transactions_list_bloc.dart';

enum TransactionsListStatus { initial, loading, success, failure }

class TransactionsListState extends Equatable {
  const TransactionsListState({
    this.status = TransactionsListStatus.initial,
    this.transactions = const [],
    this.transactionIdToDelete = 0,
  });

  final TransactionsListStatus status;
  final List<vinttem_repository.Transaction> transactions;
  final int transactionIdToDelete;

  @override
  List<Object> get props => [
        status,
        transactions,
        transactionIdToDelete,
      ];
  TransactionsListState copyWith({
    TransactionsListStatus? status,
    List<vinttem_repository.Transaction>? transactions,
    int? transactionIdToDelete,
  }) {
    return TransactionsListState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      transactionIdToDelete:
          transactionIdToDelete ?? this.transactionIdToDelete,
    );
  }
}
