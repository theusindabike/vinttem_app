import 'package:formz/formz.dart';

enum TransactionValueValidationError { invalid }

class NewTransactionValue
    extends FormzInput<double, TransactionValueValidationError> {
  const NewTransactionValue.pure([super.value = 0]) : super.pure();
  const NewTransactionValue.dirty([super.value = 0]) : super.dirty();

  @override
  TransactionValueValidationError? validator(double value) {
    return value.isNegative ? TransactionValueValidationError.invalid : null;
  }
}
