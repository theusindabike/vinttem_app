import 'package:formz/formz.dart';

enum TransactionDetailDescriptionValidationError { invalid }

class TransactionDetailDescription
    extends FormzInput<String, TransactionDetailDescriptionValidationError> {
  const TransactionDetailDescription.pure([super.value = '']) : super.pure();
  const TransactionDetailDescription.dirty([super.value = '']) : super.dirty();

  @override
  TransactionDetailDescriptionValidationError? validator(String value) {
    return value.isEmpty
        ? TransactionDetailDescriptionValidationError.invalid
        : null;
  }
}
