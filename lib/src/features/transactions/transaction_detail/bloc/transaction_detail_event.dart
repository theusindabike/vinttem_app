part of 'transaction_detail_bloc.dart';

sealed class TransactionDetailEvent extends Equatable {
  const TransactionDetailEvent();

  @override
  List<Object> get props => [];
}

final class TransactionDetailUserChanged extends TransactionDetailEvent {
  const TransactionDetailUserChanged({required this.user});
  final String user;

  @override
  List<Object> get props => [user];
}

final class TransactionDetailValueChanged extends TransactionDetailEvent {
  const TransactionDetailValueChanged({required this.value});
  final double value;

  @override
  List<Object> get props => [value];
}

final class TransactionDetailCategoryChanged extends TransactionDetailEvent {
  const TransactionDetailCategoryChanged({required this.category});

  final String category;

  @override
  List<Object> get props => [category];
}

final class TransactionDetailTypeChanged extends TransactionDetailEvent {
  const TransactionDetailTypeChanged({required this.type});

  final String type;

  @override
  List<Object> get props => [type];
}

final class TransactionDetailDescriptionChanged extends TransactionDetailEvent {
  const TransactionDetailDescriptionChanged({required this.description});

  final String description;

  @override
  List<Object> get props => [description];
}

final class TransactionDetailFormCleaned extends TransactionDetailEvent {
  const TransactionDetailFormCleaned();
}

final class TransactionDetailSubmitted extends TransactionDetailEvent {
  const TransactionDetailSubmitted();
}
