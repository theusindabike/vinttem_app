import 'package:formz/formz.dart';

enum NewTransactionCategoryValidationError { invalid }

class NewTransactionCategory
    extends FormzInput<String, NewTransactionCategoryValidationError> {
  const NewTransactionCategory.pure([super.value = '']) : super.pure();
  const NewTransactionCategory.dirty([super.value = '']) : super.dirty();

  @override
  NewTransactionCategoryValidationError? validator(String value) {
    return value.isEmpty ? NewTransactionCategoryValidationError.invalid : null;
  }
}
