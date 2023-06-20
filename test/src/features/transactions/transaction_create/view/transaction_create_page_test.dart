import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vinttem_app/src/features/transactions/transaction.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

import '../../../../../helpers/pump_app.dart';

class MockVinttemRepository extends Mock implements VinttemMockRepository {}

void main() {
  late VinttemRepository mockVinttemRepository;

  group('TransactionCreatePage', () {
    setUp(() {
      mockVinttemRepository = MockVinttemRepository();
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
