import 'package:formz/formz.dart';

enum TransactionValueValidationError { invalid }

class TransactionFormValue
    extends FormzInput<double, TransactionValueValidationError> {
  const TransactionFormValue.pure([super.value = 0]) : super.pure();
  const TransactionFormValue.dirty([super.value = 0]) : super.dirty();

  @override
  TransactionValueValidationError? validator(double value) {
    return value.isNegative ? TransactionValueValidationError.invalid : null;
  }
}
