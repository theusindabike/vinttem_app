part of 'transaction_form_bloc.dart';

sealed class TransactionFormEvent extends Equatable {
  const TransactionFormEvent();

  @override
  List<Object> get props => [];
}

final class TransactionUserChanged extends TransactionFormEvent {
  const TransactionUserChanged({required this.transactionUser});
  final String transactionUser;

  @override
  List<Object> get props => [transactionUser];
}

final class TransactionValueChanged extends TransactionFormEvent {
  const TransactionValueChanged({required this.transactionValue});
  final String transactionValue;

  @override
  List<Object> get props => [transactionValue];
}

final class TransactionSubmitted extends TransactionFormEvent {
  const TransactionSubmitted();
}
