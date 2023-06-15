import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vinttem_app/src/features/transactions/new_transaction/view/transaction_create_page.dart';
import 'package:vinttem_app/src/features/transactions/new_transaction/view/view.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

import '../../../../../helpers/pump_app.dart';

class MockVinttemRepository extends Mock implements VinttemMockRepository {}

void main() {
  late VinttemRepository mockVinttemRepository;

  const mockTransaction = Transaction(
    user: TransactionUser.matheus,
    value: 6.66,
    category: TransactionCategory.cloths,
    type: TransactionType.even,
  );
  group('TransactionCreatePage', () {
    setUp(() {
      mockVinttemRepository = MockVinttemRepository();
      // when(() => mockVinttemRepository.createTransaction(mockTransaction))
      //     .thenAnswer((_) => Future<Transaction>.value(mockTransaction));
    });
    testWidgets('Render transaction create view', (tester) async {
      await tester.pumpApp(
        const TransactionCreatePage(),
        vinttemRepository: mockVinttemRepository,
      );

      expect(find.byType(TransactionCreateForm), findsOneWidget);
    });
  });
}
