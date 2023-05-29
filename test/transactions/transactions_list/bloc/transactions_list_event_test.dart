import 'package:flutter_test/flutter_test.dart';
import 'package:vinttem_app/transactions/transaction.dart';

void main() {
  group('TransactionsListEvent', () {
    test(
      'support value equality',
      () => expect(
        const TransactionsListRequested(),
        equals(const TransactionsListRequested()),
      ),
    );

    test(
      'empty props when TransactionsListSubscriptionRequested',
      () => expect(
        const TransactionsListRequested().props,
        equals(<Object?>[]),
      ),
    );
  });
}
