import 'package:formz/formz.dart';

enum TransactionCreateTypeValidationError { invalid }

class TransactionCreateType
    extends FormzInput<String, TransactionCreateTypeValidationError> {
  const TransactionCreateType.pure([super.value = '']) : super.pure();
  const TransactionCreateType.dirty([super.value = '']) : super.dirty();

  @override
  TransactionCreateTypeValidationError? validator(String value) {
    return value.isEmpty ? TransactionCreateTypeValidationError.invalid : null;
  }
}
