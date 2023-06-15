import 'package:formz/formz.dart';

enum NewTransactionValueValidationError { invalid }

class NewTransactionValue
    extends FormzInput<double, NewTransactionValueValidationError> {
  const NewTransactionValue.pure([super.value = 0]) : super.pure();
  const NewTransactionValue.dirty([super.value = 0]) : super.dirty();

  @override
  NewTransactionValueValidationError? validator(double value) {
    return value.isNegative || value == 0
        ? NewTransactionValueValidationError.invalid
        : null;
  }
}
