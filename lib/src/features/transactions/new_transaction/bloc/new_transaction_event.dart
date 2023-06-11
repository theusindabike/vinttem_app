part of 'new_transaction_bloc.dart';

sealed class NewTransactionEvent extends Equatable {
  const NewTransactionEvent();

  @override
  List<Object> get props => [];
}

final class UserChanged extends NewTransactionEvent {
  const UserChanged({required this.user});
  final String user;

  @override
  List<Object> get props => [user];
}

final class ValueChanged extends NewTransactionEvent {
  const ValueChanged({required this.value});
  final double value;

  @override
  List<Object> get props => [value];
}

final class NewTransactionSubmitted extends NewTransactionEvent {
  const NewTransactionSubmitted();
}
