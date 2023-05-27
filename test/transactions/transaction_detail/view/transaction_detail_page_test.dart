import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:vinttem_app/transactions/transaction.dart'
    hide Transaction, TransactionCategory, TransactionType, TransactionUser;
import 'package:vinttem_repository/vinttem_repository.dart';

import '../../../helpers/helpers.dart';

class MockTransactionRepository extends Mock implements VinttemRepository {}

class MockTransactionsListBloc
    extends MockBloc<TransactionsListEvent, TransactionsListState>
    implements TransactionsListBloc {}

void main() {
  final mockTransactions = <Transaction>[
    Transaction(
      id: 'fake_id_1',
      user: TransactionUser.matheus,
      value: 123.45,
      category: TransactionCategory.marketStuff,
      type: TransactionType.even,
      description: 'fake description 1',
    ),
    Transaction(
      id: 'fake_id_2',
      user: TransactionUser.matheus,
      value: 23.45,
      category: TransactionCategory.cloths,
      type: TransactionType.proportinal,
      description: 'fake description 2',
    ),
    Transaction(
      id: 'fake_id_3',
      user: TransactionUser.matheus,
      value: 45.67,
      category: TransactionCategory.gifts,
      type: TransactionType.justMe,
      description: 'fake description 3',
    ),
  ];

  late VinttemRepository transactionRepository;
  group('TransactionDetailPage', () {
    setUp(() {});
    testWidgets('render TransactionDetailView', (tester) async {
      await tester.pumpApp(
        const TransactionDetailPage(),
      );
      expect(find.byType(TransactionDetailPage), findsOneWidget);
    });
  });

  group('TransactionDetailPage Form', () {
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
  });
}
