part of 'new_transaction_bloc.dart';

sealed class NewTransactionEvent extends Equatable {
  const NewTransactionEvent();

  @override
  List<Object> get props => [];
}

final class NewTransactionUserChanged extends NewTransactionEvent {
  const NewTransactionUserChanged({required this.user});
  final String user;

  @override
  List<Object> get props => [user];
}

final class NewTransactionValueChanged extends NewTransactionEvent {
  const NewTransactionValueChanged({required this.value});
  final double value;

  @override
  List<Object> get props => [value];
}

final class NewTransactionCategoryChanged extends NewTransactionEvent {
  const NewTransactionCategoryChanged({required this.category});

  final String category;

  @override
  List<Object> get props => [category];
}

final class NewTransactionSubmitted extends NewTransactionEvent {
  const NewTransactionSubmitted();
}
