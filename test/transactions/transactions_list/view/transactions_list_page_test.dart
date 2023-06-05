import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:vinttem_app/app/app.dart';
import 'package:vinttem_app/transactions/transaction.dart'
    hide Transaction, TransactionCategory, TransactionType, TransactionUser;
import 'package:vinttem_repository/vinttem_repository.dart';

import '../../../helpers/helpers.dart';

class MockVinttemRepository extends Mock implements VinttemRepository {}

class MockTransactionsListBloc
    extends MockBloc<TransactionsListEvent, TransactionsListState>
    implements TransactionsListBloc {}

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
      type: TransactionType.justMe,
      description: 'fake description 3',
    ),
  ];

  late VinttemRepository vinttemRepository;
  group('TransactionsListPage', () {
    setUp(() {
      vinttemRepository = MockVinttemRepository();
      when(vinttemRepository.getTransactions)
          .thenAnswer((_) => Future<List<Transaction>>.value([]));
    });
    testWidgets('render TransactionsListView', (tester) async {
      await tester.pumpWidget(App(vinttemRepository: vinttemRepository));
      expect(find.byType(TransactionsListView), findsOneWidget);
    });

    testWidgets(
      'on initialization calls getTransactions',
      (tester) async {
        await tester.pumpWidget(App(vinttemRepository: vinttemRepository));
        verify(() => vinttemRepository.getTransactions()).called(1);
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

      vinttemRepository = MockVinttemRepository();

      when(
        () => vinttemRepository.getTransactions(),
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
        vinttemRepository: vinttemRepository,
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
        //     const TransactionsListState(
        //status: TransactionsListStatus.failure)
        //   ]),
        // );

        await tester.pumpApp(
          buildNavigatorRoute(),
          vinttemRepository: vinttemRepository,
        );
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
      },
      skip: true,
    );
  });
}
