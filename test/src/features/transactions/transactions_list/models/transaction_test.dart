import 'package:test/test.dart';
import 'package:vinttem_app/src/features/transactions/transactions_list/models/models.dart';

void main() {
  const transaction = Transaction(
    id: 1,
    user: TransactionUser.bianca,
    value: 456.78,
    category: TransactionCategory.shopping,
    type: TransactionType.proportional,
  );

  group('Transaction', () {
    group('constructor', () {
      test('props are correct', () {
        expect(transaction.props, equals([1]));
      });
    });

    group('fromJson', () {
      test('returns a correct Transaction from json', () {
        expect(
          Transaction.fromJson(const <String, dynamic>{
            'id': 1,
            'user': 'matheus',
            'value': 123.45,
            'category': 'market_stuff',
            'type': 'even',
            'description': 'fake description 1',
          }),
          isA<Transaction>()
              .having(
                (t) => t.id,
                'id',
                1,
              )
              .having(
                (t) => t.user,
                'user',
                TransactionUser.matheus,
              )
              .having(
                (t) => t.value,
                'value',
                123.45,
              )
              .having(
                (t) => t.category,
                'category',
                TransactionCategory.marketStuff,
              )
              .having(
                (t) => t.type,
                'type',
                TransactionType.even,
              )
              .having(
                (t) => t.description,
                'description',
                'fake description 1',
              ),
        );
      });
    });

    group('toJson', () {
      test('returns a correct Transaction toJson', () {
        expect(
          transaction.toJson(),
          equals(<String, dynamic>{
            'id': 1,
            'user': 'bianca',
            'value': 456.78,
            'category': 'shopping',
            'type': 'proportional',
            'description': null
          }),
        );
      });
    });
  });
}
