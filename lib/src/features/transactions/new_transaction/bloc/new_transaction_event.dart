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

enum CategoryAction { insert, remove }

final class NewTransactionCategoriesChanged extends NewTransactionEvent {
  const NewTransactionCategoriesChanged({
    required this.category,
    required this.action,
  });

  final String category;
  final CategoryAction action;

  @override
  List<Object> get props => [category, action];
}

final class NewTransactionSubmitted extends NewTransactionEvent {
  const NewTransactionSubmitted();
}
