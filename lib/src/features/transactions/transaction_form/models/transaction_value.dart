import 'package:formz/formz.dart';

enum TransactionValueValidationError { invalid }

class TransactionValue
    extends FormzInput<double, TransactionValueValidationError> {
  const TransactionValue.pure() : super.pure(0);
  const TransactionValue.dirty({double value = 0}) : super.dirty(value);

  @override
  TransactionValueValidationError? validator(double value) {
    return value.isNegative ? TransactionValueValidationError.invalid : null;
  }
}
