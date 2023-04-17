import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail/mocktail.dart';

import 'package:vinttem_api/vinttem_api.dart';
import 'package:vinttem_app/transactions/transaction.dart'
    hide Transaction, TransactionCategory, TransactionType, TransactionUser;

import '../../../helpers/helpers.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

class MockTransactionsListBloc
    extends MockBloc<TransactionsListEvent, TransactionsListState>
    implements TransactionsListBloc {}

void main() {
  final mockTransactions = <Transaction>[
    Transaction(
      id: 'fake_id_1',
      transactionUser: TransactionUser.matheus,
      value: 123.45,
      category: TransactionCategory.marketStuff,
      type: TransactionType.even,
      description: 'fake description 1',
    ),
    Transaction(
      id: 'fake_id_2',
      transactionUser: TransactionUser.matheus,
      value: 23.45,
      category: TransactionCategory.cloths,
      type: TransactionType.proportinal,
      description: 'fake description 2',
    ),
    Transaction(
      id: 'fake_id_3',
      transactionUser: TransactionUser.matheus,
      value: 45.67,
      category: TransactionCategory.gifts,
      type: TransactionType.justMe,
      description: 'fake description 3',
    ),
  ];

  late TransactionRepository transactionRepository;
  group('TransactionsListPage', () {
    setUp(() {
      transactionRepository = MockTransactionRepository();
      when(transactionRepository.getTransactions)
          .thenAnswer((_) => Future<List<Transaction>>.value([]));
    });
    testWidgets('render TransactionsListView', (tester) async {
      await tester.pumpApp(
        const TransactionsListPage(),
        transactionRepository: transactionRepository,
      );
      expect(find.byType(TransactionsListView), findsOneWidget);
    });

    testWidgets(
      'on initialization calls getTransactions repo',
      (tester) async {
        await tester.pumpApp(
          const TransactionsListPage(),
          transactionRepository: transactionRepository,
        );

        verify(() => transactionRepository.getTransactions()).called(1);
      },
    );
  });

  group('TransactionsListView', () {
    late MockNavigator navigator;
    late TransactionsListBloc transactionsListBloc;

    setUp(() {
      navigator = MockNavigator();
      when(() => navigator.push<void>(any())).thenAnswer((_) async {});

      transactionsListBloc = MockTransactionsListBloc();
      when(() => transactionsListBloc.state).thenReturn(
        TransactionsListState(
          status: TransactionsListStatus.success,
          transactions: mockTransactions,
        ),
      );

      transactionRepository = MockTransactionRepository();

      when(
        () => transactionRepository.getTransactions(),
      ).thenAnswer((_) => Future.value(mockTransactions));
    });

    Widget buildNavigatorRoute() {
      return MockNavigatorProvider(
        navigator: navigator,
        child: BlocProvider.value(
          value: transactionsListBloc,
          child: const TransactionsListView(),
        ),
      );
    }

    testWidgets('renders transactionList cards', (tester) async {
      await tester.pumpApp(
        buildNavigatorRoute(),
        transactionRepository: transactionRepository,
      );

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets(
      'shows an error snackbar when getTransactionList fails',
      (tester) async {
        when(() => transactionsListBloc.state).thenReturn(
          const TransactionsListState(status: TransactionsListStatus.failure),
        );

        // whenListen<TransactionsListState>(
        //   transactionsListBloc,
        //   Stream.fromIterable([
        //     const TransactionsListState(),
        //     const TransactionsListState(status: TransactionsListStatus.failure)
        //   ]),
        // );

        await tester.pumpApp(
          buildNavigatorRoute(),
          transactionRepository: transactionRepository,
        );
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
      },
      skip: true,
    );
  });
}
