part of 'transaction_form_bloc.dart';

final class TransactionFormState extends Equatable {
  const TransactionFormState({
    this.transactionUser = const TransactionUser.pure(),
    this.transactionValue = const TransactionValue.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final TransactionUser transactionUser;
  final TransactionValue transactionValue;
  final bool isValid;
  final FormzSubmissionStatus status;

  TransactionFormState copyWith({
    TransactionUser? transactionUser,
    TransactionValue? transactionValue,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return TransactionFormState(
      transactionUser: transactionUser ?? this.transactionUser,
      transactionValue: transactionValue ?? this.transactionValue,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [transactionUser, transactionValue];
}
