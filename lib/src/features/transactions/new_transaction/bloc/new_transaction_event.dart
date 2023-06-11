part of 'new_transaction_bloc.dart';

sealed class TransactionFormEvent extends Equatable {
  const TransactionFormEvent();

  @override
  List<Object> get props => [];
}

final class TransactionUserChanged extends TransactionFormEvent {
  const TransactionUserChanged({required this.user});
  final String user;

  @override
  List<Object> get props => [user];
}

final class TransactionValueChanged extends TransactionFormEvent {
  const TransactionValueChanged({required this.value});
  final double value;

  @override
  List<Object> get props => [value];
}

final class TransactionSubmitted extends TransactionFormEvent {
  const TransactionSubmitted();
}
