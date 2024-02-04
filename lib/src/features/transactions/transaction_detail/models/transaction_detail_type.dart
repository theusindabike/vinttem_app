import 'package:formz/formz.dart';

enum TransactionDetailTypeValidationError { invalid }

class TransactionDetailType
    extends FormzInput<String, TransactionDetailTypeValidationError> {
  const TransactionDetailType.pure([super.value = '']) : super.pure();
  const TransactionDetailType.dirty([super.value = '']) : super.dirty();

  @override
  TransactionDetailTypeValidationError? validator(String value) {
    return value.isEmpty ? TransactionDetailTypeValidationError.invalid : null;
  }
}
