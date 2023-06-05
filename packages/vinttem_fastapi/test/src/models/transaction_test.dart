import 'package:test/test.dart';
import 'package:vinttem_fastapi/src/models/models.dart';

void main() {
  final transactionJson = <String, dynamic>{
    'id': 1,
    'user': 'matheus',
    'value': 123.45,
    'category': 'marketStuff',
    'type': 'even',
    'description': 'fake description 1',
  };
  group(
    'Transaction',
    () => {
      group('fromJson', () {
        test('return correct Transction object', () {
          expect(
            Transaction.fromJson(transactionJson),
            isA<Transaction>()
                .having((t) => t.id, 'id', 1)
                .having((t) => t.user, 'user', TransactionUser.matheus)
                .having((t) => t.value, 'value', 123.45)
                .having(
                  (t) => t.category,
                  'category',
                  TransactionCategory.marketStuff,
                )
                .having((t) => t.type, 'type', TransactionType.even)
                .having(
                  (t) => t.description,
                  'description',
                  'fake description 1',
                ),
          );
        });
      })
    },
  );
}
