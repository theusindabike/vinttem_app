part of 'transaction_detail_bloc.dart';

class TransactionDetailState extends Equatable {
  const TransactionDetailState({
    this.status = FormzSubmissionStatus.initial,
    this.user = const TransactionDetailUser.pure(),
    this.value = const TransactionDetailValue.pure(),
    this.category = const TransactionDetailCategory.pure(),
    this.type = const TransactionDetailType.pure(),
    this.description = const TransactionDetailDescription.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final TransactionDetailUser user;
  final TransactionDetailValue value;
  final TransactionDetailCategory category;
  final TransactionDetailType type;
  final TransactionDetailDescription description;
  final bool isValid;

  TransactionDetailState copyWith({
    FormzSubmissionStatus? status,
    TransactionDetailUser? user,
    TransactionDetailValue? value,
    TransactionDetailCategory? category,
    TransactionDetailType? type,
    TransactionDetailDescription? description,
    bool? isValid,
  }) {
    return TransactionDetailState(
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
