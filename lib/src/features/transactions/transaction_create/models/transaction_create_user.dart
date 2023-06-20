import 'package:formz/formz.dart';

enum TransactionCreateUserValidationError { invalid }

class TransactionCreateUser
    extends FormzInput<String, TransactionCreateUserValidationError> {
  const TransactionCreateUser.pure([super.value = '']) : super.pure();
  const TransactionCreateUser.dirty([super.value = '']) : super.dirty();

  @override
  TransactionCreateUserValidationError? validator(String value) {
    return value.isEmpty ? TransactionCreateUserValidationError.invalid : null;
  }
}
