part of 'transaction_create_bloc.dart';

sealed class TransactionCreateEvent extends Equatable {
  const TransactionCreateEvent();

  @override
  List<Object> get props => [];
}

final class TransactionCreateUserChanged extends TransactionCreateEvent {
  const TransactionCreateUserChanged({required this.user});
  final String user;

  @override
  List<Object> get props => [user];
}

final class TransactionCreateValueChanged extends TransactionCreateEvent {
  const TransactionCreateValueChanged({required this.value});
  final double value;

  @override
  List<Object> get props => [value];
}

final class TransactionCreateCategoryChanged extends TransactionCreateEvent {
  const TransactionCreateCategoryChanged({required this.category});

  final String category;

  @override
  List<Object> get props => [category];
}

final class TransactionCreateSubmitted extends TransactionCreateEvent {
  const TransactionCreateSubmitted();
}
