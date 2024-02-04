import 'package:formz/formz.dart';

enum TransactionDetailUserValidationError { invalid }

class TransactionDetailUser
    extends FormzInput<String, TransactionDetailUserValidationError> {
  const TransactionDetailUser.pure([super.value = '']) : super.pure();
  const TransactionDetailUser.dirty([super.value = '']) : super.dirty();

  @override
  TransactionDetailUserValidationError? validator(String value) {
    return value.isEmpty ? TransactionDetailUserValidationError.invalid : null;
  }
}
