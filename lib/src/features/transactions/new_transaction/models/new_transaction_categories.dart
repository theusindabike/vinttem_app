import 'package:formz/formz.dart';

enum NewTransactionCategoriesValidationError { isEmpty, invalid }

class NewTransactionCategories
    extends FormzInput<Set<String>, NewTransactionCategoriesValidationError> {
  // const NewTransasactionCategories.pure([super.value = const []])
  //     : super.pure();
  const NewTransactionCategories.pure([super.value = const {}]) : super.pure();
  const NewTransactionCategories.dirt([super.value = const {}]) : super.dirty();

  @override
  NewTransactionCategoriesValidationError? validator(Set<String> value) {
    return value.isEmpty
        ? NewTransactionCategoriesValidationError.isEmpty
        : null;
  }
}
