part of 'new_transaction_bloc.dart';

final class TransactionFormState extends Equatable {
  const TransactionFormState({
    this.status = FormzSubmissionStatus.initial,
    this.user = const TransactionFormUser.pure(),
    this.value = const TransactionFormValue.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final TransactionFormUser user;
  final TransactionFormValue value;
  final bool isValid;

  TransactionFormState copyWith({
    TransactionFormUser? user,
    TransactionFormValue? value,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return TransactionFormState(
      status: status ?? this.status,
      user: user ?? this.user,
      value: value ?? this.value,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, user, value];
}
