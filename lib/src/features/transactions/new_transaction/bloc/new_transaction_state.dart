part of 'new_transaction_bloc.dart';

final class NewTransactionState extends Equatable {
  const NewTransactionState({
    this.status = FormzSubmissionStatus.initial,
    this.user = const NewTransactionUser.pure(),
    this.value = const NewTransactionValue.pure(),
    this.category = const NewTransactionCategory.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final NewTransactionUser user;
  final NewTransactionValue value;
  final NewTransactionCategory category;
  final bool isValid;

  NewTransactionState copyWith({
    NewTransactionUser? user,
    NewTransactionValue? value,
    NewTransactionCategory? category,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return NewTransactionState(
      status: status ?? this.status,
      user: user ?? this.user,
      value: value ?? this.value,
      category: category ?? this.category,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, user, value, category];
}
