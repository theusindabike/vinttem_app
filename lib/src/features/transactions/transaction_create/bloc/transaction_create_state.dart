part of 'transaction_create_bloc.dart';

final class TransactionCreateState extends Equatable {
  const TransactionCreateState({
    this.status = FormzSubmissionStatus.initial,
    this.user = const TransactionCreateUser.pure(),
    this.value = const TransactionCreateValue.pure(),
    this.category = const TransactionCreateCategory.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final TransactionCreateUser user;
  final TransactionCreateValue value;
  final TransactionCreateCategory category;
  final bool isValid;

  TransactionCreateState copyWith({
    TransactionCreateUser? user,
    TransactionCreateValue? value,
    TransactionCreateCategory? category,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return TransactionCreateState(
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
