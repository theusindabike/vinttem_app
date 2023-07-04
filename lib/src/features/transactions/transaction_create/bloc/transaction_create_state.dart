part of 'transaction_create_bloc.dart';

class TransactionCreateState extends Equatable {
  const TransactionCreateState({
    this.status = FormzSubmissionStatus.initial,
    this.user = const TransactionCreateUser.pure(),
    this.value = const TransactionCreateValue.pure(),
    this.category = const TransactionCreateCategory.pure(),
    this.type = const TransactionCreateType.pure(),
    this.description = const TransactionCreateDescription.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final TransactionCreateUser user;
  final TransactionCreateValue value;
  final TransactionCreateCategory category;
  final TransactionCreateType type;
  final TransactionCreateDescription description;
  final bool isValid;

  TransactionCreateState copyWith({
    FormzSubmissionStatus? status,
    TransactionCreateUser? user,
    TransactionCreateValue? value,
    TransactionCreateCategory? category,
    TransactionCreateType? type,
    TransactionCreateDescription? description,
    bool? isValid,
  }) {
    return TransactionCreateState(
      status: status ?? this.status,
      user: user ?? this.user,
      value: value ?? this.value,
      category: category ?? this.category,
      type: type ?? this.type,
      description: description ?? this.description,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, user, value, category, type, description];
}
