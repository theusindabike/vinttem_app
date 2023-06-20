import 'package:test/test.dart';
import 'package:vinttem_repository/src/models/models.dart';

void main() {
  group('Transaction', () {
    final transactionJson = <String, dynamic>{
      'id': 1,
      'user': 'matheus',
      'value': 123.45,
      'category': 'marketStuff',
      'type': 'even',
      'description': 'fake description 1',
    };

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
    });
    test('return correct TransactionUser using getByName', () {
      expect(
        TransactionUser.getByName('Matheus'),
        TransactionUser.matheus,
      );
    });

    test('return correct TransactionCategory using getByName', () {
      expect(
        TransactionCategory.getByName('Health'),
        TransactionCategory.health,
      );
    });

    test('return correct TransactionType using getByName', () {
      expect(
        TransactionType.getByName('Even'),
        TransactionType.even,
      );
    });
  });
}
