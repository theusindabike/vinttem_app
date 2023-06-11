import 'package:formz/formz.dart';

enum TransactionUserValidationError { invalid }

class TransactionUser
    extends FormzInput<String, TransactionUserValidationError> {
  const TransactionUser.pure([super.value = '']) : super.pure();
  const TransactionUser.dirty([super.value = '']) : super.dirty();

  @override
  TransactionUserValidationError? validator(String value) {
    return value.isEmpty ? TransactionUserValidationError.invalid : null;
  }
}
