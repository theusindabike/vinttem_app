import 'package:formz/formz.dart';

enum TransactionDetailValueValidationError { invalid }

class TransactionDetailValue
    extends FormzInput<double, TransactionDetailValueValidationError> {
  const TransactionDetailValue.pure([super.value = 0]) : super.pure();
  const TransactionDetailValue.dirty([super.value = 0]) : super.dirty();

  @override
  TransactionDetailValueValidationError? validator(double value) {
    return value.isNegative || value == 0
        ? TransactionDetailValueValidationError.invalid
        : null;
  }
}
