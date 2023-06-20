import 'package:formz/formz.dart';

enum TransactionCreateValueValidationError { invalid }

class TransactionCreateValue
    extends FormzInput<double, TransactionCreateValueValidationError> {
  const TransactionCreateValue.pure([super.value = 0]) : super.pure();
  const TransactionCreateValue.dirty([super.value = 0]) : super.dirty();

  @override
  TransactionCreateValueValidationError? validator(double value) {
    return value.isNegative || value == 0
        ? TransactionCreateValueValidationError.invalid
        : null;
  }
}
