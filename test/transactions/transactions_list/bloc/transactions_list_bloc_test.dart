import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vinttem_app/transactions/transaction.dart'
    hide Transaction, TransactionCategory, TransactionType, TransactionUser;
import 'package:vinttem_repository/vinttem_repository.dart';

class MockTransactionRepository extends Mock implements VinttemRepository {}

class FakeTransaction extends Fake implements Transaction {}

void main() {
  final mockTransactions = <Transaction>[
    const Transaction(
      id: 'fake_id_1',
      user: TransactionUser.matheus,
      value: 123.45,
      category: TransactionCategory.marketStuff,
      type: TransactionType.even,
      description: 'fake description 1',
    ),
    const Transaction(
      id: 'fake_id_2',
      user: TransactionUser.matheus,
      value: 23.45,
      category: TransactionCategory.cloths,
      type: TransactionType.proportinal,
      description: 'fake description 2',
    ),
    const Transaction(
      id: 'fake_id_3',
      user: TransactionUser.matheus,
      value: 45.67,
      category: TransactionCategory.gifts,
      type: TransactionType.justMe,
      description: 'fake description 3',
    ),
  ];
  group('TransactionListBloc', () {
    late VinttemRepository transactionRepository;

    setUpAll(() {
      registerFallbackValue(FakeTransaction());
    });

    setUp(() {
      transactionRepository = MockTransactionRepository();

      when(
        () => transactionRepository.getTransactions(),
      ).thenAnswer((_) => Future.value(mockTransactions));
    });

    TransactionsListBloc buildBloc() {
      return TransactionsListBloc(vinttemRepository: transactionRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(const TransactionsListState()),
        );
      });
    });

    group('TransactionsListSubscriptionRequested', () {
      blocTest<TransactionsListBloc, TransactionsListState>(
        'start subscription to Transactions repostiory',
        build: buildBloc,
        act: (bloc) => bloc.add(const TransactionsListRequested()),
        verify: (_) {
          verify(() => transactionRepository.getTransactions()).called(1);
        },
      );
      blocTest<TransactionsListBloc, TransactionsListState>(
        'emits updated status when a getTransctions call occurs',
        build: buildBloc,
        act: (bloc) => bloc.add(const TransactionsListRequested()),
        expect: () => [
          const TransactionsListState(
            status: TransactionsListStatus.loading,
          ),
          TransactionsListState(
            status: TransactionsListStatus.success,
            transactions: mockTransactions,
          ),
        ],
      );

      blocTest<TransactionsListBloc, TransactionsListState>(
        'emits failure status when a getTransctions error occurs',
        setUp: () {
          when(
            () => transactionRepository.getTransactions(),
          ).thenAnswer(
            (_) => Future.error(
              Exception('sorry to say, but something went wrong'),
            ),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const TransactionsListRequested()),
        expect: () => [
          const TransactionsListState(status: TransactionsListStatus.loading),
          const TransactionsListState(status: TransactionsListStatus.failure),
        ],
      );
    });
  });
}
