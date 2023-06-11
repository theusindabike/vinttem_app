import 'package:formz/formz.dart';

enum NewTransactionUserValidationError { invalid }

class NewTransactionUser
    extends FormzInput<String, NewTransactionUserValidationError> {
  const NewTransactionUser.pure([super.value = '']) : super.pure();
  const NewTransactionUser.dirty([super.value = '']) : super.dirty();

  @override
  NewTransactionUserValidationError? validator(String value) {
    return value.isEmpty ? NewTransactionUserValidationError.invalid : null;
  }
}
