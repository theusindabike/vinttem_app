import 'package:formz/formz.dart';

enum TransactionDetailCategoryValidationError { invalid }

class TransactionDetailCategory
    extends FormzInput<String, TransactionDetailCategoryValidationError> {
  const TransactionDetailCategory.pure([super.value = '']) : super.pure();
  const TransactionDetailCategory.dirty([super.value = '']) : super.dirty();

  @override
  TransactionDetailCategoryValidationError? validator(String value) {
    return value.isEmpty
        ? TransactionDetailCategoryValidationError.invalid
        : null;
  }
}
