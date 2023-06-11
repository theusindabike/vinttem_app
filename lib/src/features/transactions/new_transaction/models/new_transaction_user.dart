import 'package:formz/formz.dart';

enum TransactionUserValidationError { invalid }

class TransactionFormUser
    extends FormzInput<String, TransactionUserValidationError> {
  const TransactionFormUser.pure([super.value = '']) : super.pure();
  const TransactionFormUser.dirty([super.value = '']) : super.dirty();

  @override
  TransactionUserValidationError? validator(String value) {
    return value.isEmpty ? TransactionUserValidationError.invalid : null;
  }
}
