import 'package:test/test.dart';
import 'package:vinttem_app/transactions/models/models.dart';

void main() {
  const transaction = Transaction(
    id: 'fake_id_1',
    user: TransactionUser.bianca,
    value: 456.78,
    category: TransactionCategory.buyingSomething,
    type: TransactionType.proportional,
  );

  group('Transaction', () {
    group('constructor', () {
      test('props are correct', () {
        expect(transaction.props, equals(['fake_id_1']));
      });
    });

    group('fromJson', () {
      test('returns a correct Transaction from json', () {
        expect(
          Transaction.fromJson(const <String, dynamic>{
            'id': 'fake_id_1',
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
                'fake_id_1',
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
            'id': 'fake_id_1',
            'user': 'bianca',
            'value': 456.78,
            'category': 'buying_something',
            'type': 'proportional',
            'description': null
          }),
        );
      });
    });
  });
}
