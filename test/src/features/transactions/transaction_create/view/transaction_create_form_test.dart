import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vinttem_app/src/features/transactions/transaction_create/transaction_create.dart';
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
  const saveButtonKey = Key('TransactionCreateForm_save_raisedButton');
  const userWrapKey = Key('TransactionCreateForm_user_wrap');
  const valueTextFieldKey = Key('TransactionCreateForm_value_textField');
  const categoryWrapKey = Key('TransactionCreateForm_category_wrap');
  const typeWrapKey = Key('TransactionCreateForm_type_wrap');
  const descriptionTextFieldKey =
      Key('TransactionCreateForm_description_textField');
  const cleanFormButtonKey = Key('TransactionCreateForm_clean_raisedButton');

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
              TransactionCreateBloc(vinttemRepository: mockVinttemRepository),
          child: const TransactionCreateForm(),
        ),
      );

      expect(find.byKey(userWrapKey), findsOneWidget);
      expect(find.byKey(valueTextFieldKey), findsOneWidget);
      expect(find.byKey(categoryWrapKey), findsOneWidget);
      expect(find.byKey(typeWrapKey), findsOneWidget);
      expect(find.byKey(descriptionTextFieldKey), findsOneWidget);
      expect(find.byKey(cleanFormButtonKey), findsOneWidget);
      expect(find.byKey(saveButtonKey), findsOneWidget);
    });

    testWidgets('Enabled submit button when valid fields', (tester) async {
      await tester.pumpApp(
        BlocProvider(
          create: (context) =>
              TransactionCreateBloc(vinttemRepository: mockVinttemRepository),
          child: const TransactionCreateForm(),
        ),
      );

      await tester.tap(find.bySemanticsLabel('Matheus'));
      await tester.pump();

      await tester.enterText(find.byKey(valueTextFieldKey), '0,01');
      await tester.pump();

      await tester.tap(find.bySemanticsLabel('Recreation'));
      await tester.pump();

      await tester.tap(find.bySemanticsLabel('Even'));
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
              TransactionCreateBloc(vinttemRepository: mockVinttemRepository),
          child: const TransactionCreateForm(),
        ),
      );

      await tester.tap(find.bySemanticsLabel('Matheus'));
      await tester.pump();

      await tester.enterText(find.byKey(valueTextFieldKey), '0,00');
      await tester.pump();

      expect(
        tester.widget<ElevatedButton>(find.byKey(saveButtonKey)).enabled,
        isFalse,
      );
    });

    testWidgets('Clean form when press Clean button', (tester) async {
      await tester.pumpApp(
        BlocProvider(
          create: (context) =>
              TransactionCreateBloc(vinttemRepository: mockVinttemRepository),
          child: const TransactionCreateForm(),
        ),
      );

      await tester.tap(find.bySemanticsLabel('Matheus'));
      await tester.pump();

      await tester.enterText(find.byKey(valueTextFieldKey), '6,66');
      await tester.pump();

      await tester.tap(find.bySemanticsLabel('Recreation'));
      await tester.pump();

      await tester.tap(find.bySemanticsLabel('Even'));
      await tester.pump();

      expect(
        tester.widget<ElevatedButton>(find.byKey(saveButtonKey)).enabled,
        isTrue,
      );
      expect(
        find.byWidgetPredicate(
          (Widget widget) => widget is FilterChip && widget.selected,
        ),
        findsNWidgets(3),
      );

      await tester.tap(find.byKey(cleanFormButtonKey));
      await tester.pump();

      expect(find.text(r'R$ 0,00'), findsOneWidget);
      expect(
        tester.widget<ElevatedButton>(find.byKey(saveButtonKey)).enabled,
        isFalse,
      );
      expect(
        find.byWidgetPredicate(
          (Widget widget) => widget is ChoiceChip && widget.selected,
        ),
        findsNothing,
      );
    });
  });
}
