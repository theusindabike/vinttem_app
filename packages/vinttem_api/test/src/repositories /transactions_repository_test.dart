import 'package:test/test.dart';
import 'package:vinttem_api/src/repositories%20/repositories.dart';

void main() {
  group('Vinttem API Repository', () {
    late TransactionRepository transactionRepository;

    setUp(() {
      transactionRepository = TransactionRepository();
    });
  });
}
