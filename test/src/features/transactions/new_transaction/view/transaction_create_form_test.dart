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
  const saveButtonKey = Key('newTransactionForm_save_raisedButton');
  const userWrapKey = Key('newTransactionForm_user_wrap');
  const valueFieldKey = Key('newTransactionForm_value_textField');

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
      );

      expect(
        find.byKey(userWrapKey),
        findsOneWidget,
      );
      expect(
        find.byKey(valueFieldKey),
        findsOneWidget,
      );
      expect(
        find.byKey(saveButtonKey),
        findsOneWidget,
      );
    });

    testWidgets('Enabled submit button when valid fields', (tester) async {
      await tester.pumpApp(
        BlocProvider(
          create: (context) =>
              NewTransactionBloc(vinttemRepository: mockVinttemRepository),
          child: const TransactionCreateForm(),
        ),
      );

      await tester.tap(find.bySemanticsLabel('Matheus'));
      await tester.pump();

      await tester.enterText(find.byKey(valueFieldKey), '0,01');
      await tester.pump();

      expect(
        tester.widget<ElevatedButton>(find.byKey(saveButtonKey)).enabled,
        isTrue,
      );
    });

    testWidgets('Disabled submit button when invalid fields', (tester) async {
      await tester.pumpApp(
        BlocProvider(
          create: (context) =>
              NewTransactionBloc(vinttemRepository: mockVinttemRepository),
          child: const TransactionCreateForm(),
        ),
      );

      await tester.tap(find.bySemanticsLabel('Matheus'));
      await tester.pump();

      await tester.enterText(find.byKey(valueFieldKey), '0,00');
      await tester.pump();

      expect(
        tester.widget<ElevatedButton>(find.byKey(saveButtonKey)).enabled,
        isFalse,
      );
    });
  });
}
