import 'package:flutter_test/flutter_test.dart';
import 'package:vinttem_app/transactions/transaction.dart';

void main() {
  group('TransactionsListEvent', () {
    test(
      'support value equality',
      () => expect(
        const TransactionsListSubscriptionRequested(),
        equals(const TransactionsListSubscriptionRequested()),
      ),
    );

    test(
      'empty props when TransactionsListSubscriptionRequested',
      () => expect(
        const TransactionsListSubscriptionRequested().props,
        equals(<Object?>[]),
      ),
    );
  });
}
