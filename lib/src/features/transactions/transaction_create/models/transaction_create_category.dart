import 'package:formz/formz.dart';

enum TransactionCreateCategoryValidationError { invalid }

class TransactionCreateCategory
    extends FormzInput<String, TransactionCreateCategoryValidationError> {
  const TransactionCreateCategory.pure([super.value = '']) : super.pure();
  const TransactionCreateCategory.dirty([super.value = '']) : super.dirty();

  @override
  TransactionCreateCategoryValidationError? validator(String value) {
    return value.isEmpty
        ? TransactionCreateCategoryValidationError.invalid
        : null;
  }
}
