import 'package:formz/formz.dart';

enum TransactionCreateDescriptionValidationError { invalid }

class TransactionCreateDescription
    extends FormzInput<String, TransactionCreateDescriptionValidationError> {
  const TransactionCreateDescription.pure([super.value = '']) : super.pure();
  const TransactionCreateDescription.dirty([super.value = '']) : super.dirty();

  @override
  TransactionCreateDescriptionValidationError? validator(String value) {
    return value.isEmpty
        ? TransactionCreateDescriptionValidationError.invalid
        : null;
  }
}
