import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vinttem_app/src/features/transactions/transaction.dart'
    hide Transaction, TransactionCategory, TransactionType, TransactionUser;
import 'package:vinttem_repository/vinttem_repository.dart';

class MockVinttemRepository extends Mock implements VinttemRepository {}

class FakeTransaction extends Fake implements Transaction {}

void main() {
  final mockTransactions = <Transaction>[
    const Transaction(
      id: 1,
      user: TransactionUser.matheus,
      value: 123.45,
      category: TransactionCategory.marketStuff,
      type: TransactionType.even,
      description: 'fake description 1',
    ),
    const Transaction(
      id: 2,
      user: TransactionUser.matheus,
      value: 23.45,
      category: TransactionCategory.cloths,
      type: TransactionType.proportional,
      description: 'fake description 2',
    ),
    const Transaction(
      id: 3,
      user: TransactionUser.matheus,
      value: 45.67,
      category: TransactionCategory.gifts,
      type: TransactionType.individual,
      description: 'fake description 3',
    ),
  ];
  group('TransactionListBloc', () {
    late VinttemRepository mockVinttemRepository;

    setUpAll(() {
      registerFallbackValue(FakeTransaction());
    });

    setUp(() {
      mockVinttemRepository = MockVinttemRepository();

      when(
        () => mockVinttemRepository.getTransactions(),
      ).thenAnswer((_) => Future.value(mockTransactions));

      when(
        () => mockVinttemRepository.deleteTransaction(any()),
      ).thenAnswer((_) async => Future.value());
    });

    TransactionsListBloc buildBloc() {
      return TransactionsListBloc(vinttemRepository: mockVinttemRepository);
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

    group('TransactionsListRequested', () {
      blocTest<TransactionsListBloc, TransactionsListState>(
        'start subscription to Transactions repository',
        build: buildBloc,
        act: (bloc) => bloc.add(const TransactionsListRequested()),
        verify: (_) {
          verify(() => mockVinttemRepository.getTransactions()).called(1);
        },
      );
      blocTest<TransactionsListBloc, TransactionsListState>(
        'emits updated status when a getTransactions call occurs',
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
        'emits failure status when a getTransactions error occurs',
        setUp: () {
          when(
            () => mockVinttemRepository.getTransactions(),
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

    group('TransactionsListDeleteRequested', () {
      blocTest<TransactionsListBloc, TransactionsListState>(
        'start subscription to Transactions Delete repository',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(const TransactionsListDeleteRequested(transactionId: 0)),
        verify: (_) {
          verify(() => mockVinttemRepository.deleteTransaction(0)).called(1);
        },
      );

      blocTest<TransactionsListBloc, TransactionsListState>(
        'emits failure status when a getTransactions error occurs',
        setUp: () {
          when(
            () => mockVinttemRepository.deleteTransaction(0),
          ).thenAnswer(
            (_) => Future.error(
              Exception('sorry to say, but something went wrong'),
            ),
          );
        },
        build: buildBloc,
        act: (bloc) =>
            bloc.add(const TransactionsListDeleteRequested(transactionId: 0)),
        expect: () => [
          const TransactionsListState(status: TransactionsListStatus.failure),
        ],
      );
    });
  });
}
