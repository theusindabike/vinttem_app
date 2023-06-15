import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vinttem_app/src/features/transactions/new_transaction/new_transaction.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

import '../../../../../helpers/pump_app.dart';

class MockVinttemRepository extends Mock implements VinttemMockRepository {}

void main() {
  late VinttemRepository mockVinttemRepository;

  const mockTransaction = Transaction(
    user: TransactionUser.matheus,
    value: 6.66,
    category: TransactionCategory.donations,
    type: TransactionType.even,
  );

  group('TransactionCreateForm', () {
    setUp(() {
      mockVinttemRepository = MockVinttemRepository();
      when(() => mockVinttemRepository.createTransaction(mockTransaction))
          .thenAnswer((_) => Future<Transaction>.value(mockTransaction));
    });
    testWidgets('Render form fields', (tester) async {
      await tester.pumpApp(
        BlocProvider(
          create: (context) =>
              NewTransactionBloc(vinttemRepository: mockVinttemRepository),
          child: const TransactionCreateForm(),
        ),
        vinttemRepository: mockVinttemRepository,
      );

      expect(
        find.byKey(const Key('newTransactionForm_value_textField')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('newTransactionForm_user_wrap')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('newTransactionForm_value_textField')),
        findsOneWidget,
      );
    });

    testWidgets('Throw error when invalid fields', (tester) async {});
  });
}
