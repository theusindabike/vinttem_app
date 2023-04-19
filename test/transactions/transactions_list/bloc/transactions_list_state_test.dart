import 'package:flutter_test/flutter_test.dart';
import 'package:vinttem_app/transactions/transaction.dart'
    hide Transaction, TransactionCategory, TransactionType, TransactionUser;
import 'package:vinttem_repository/vinttem_repository.dart';

void main() {
  final mockTransaction = Transaction(
    id: 'fake_id_1',
    transactionUser: TransactionUser.matheus,
    value: 123.45,
    category: TransactionCategory.marketStuff,
    type: TransactionType.even,
    description: 'fake description 1',
  );

  final mockTransactions = [mockTransaction];
  group('TransactionsListState', () {
    TransactionsListState createTransactionsListState({
      TransactionsListStatus status = TransactionsListStatus.initial,
      List<Transaction>? transactions,
    }) {
      return TransactionsListState(
        status: status,
        transactions: transactions ?? mockTransactions,
      );
    }

    test(
      'support value equality',
      () => expect(
        createTransactionsListState(),
        equals(createTransactionsListState()),
      ),
    );

    test(
      'correct props when TransactionsListState',
      () => expect(
        createTransactionsListState(
          status: TransactionsListStatus.success,
          transactions: mockTransactions,
        ).props,
        equals(<Object?>[
          TransactionsListStatus.success,
          mockTransactions,
        ]),
      ),
    );

    group('copyWith', () {
      test('returns the same object with no argument ara provided', () {
        expect(
          createTransactionsListState().copyWith(),
          equals(
            createTransactionsListState(),
          ),
        );
      });

      test('retains old values if all parameters are null', () {
        expect(
          createTransactionsListState()
              // ignore: avoid_redundant_argument_values
              .copyWith(status: null, transactions: null),
          equals(
            createTransactionsListState(),
          ),
        );
      });

      test('replaces all non-null parameter', () {
        expect(
          createTransactionsListState().copyWith(
            status: TransactionsListStatus.loading,
            transactions: mockTransactions,
          ),
          equals(
            createTransactionsListState(
              status: TransactionsListStatus.loading,
              transactions: mockTransactions,
            ),
          ),
        );
      });
    });
  });
}
