import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:vinttem_fastapi/vinttem_fastapi.dart' as vinttem_fastapi_client;
import 'package:vinttem_repository/src/models/transaction.dart';
import 'package:vinttem_repository/src/repositories/fastapi_repository.dart';

class MockTransaction extends Mock
    implements vinttem_fastapi_client.Transaction {}

class MockVinttemFastAPIClient extends Mock
    implements vinttem_fastapi_client.VinttemFastAPI {}

void main() {
  group('FastAPIRepository', () {
    late vinttem_fastapi_client.VinttemFastAPI mockVinttemFastAPIClient;
    late VinttemFastAPIRespository mockFastAPIRespository;

    setUp(() {
      mockVinttemFastAPIClient = MockVinttemFastAPIClient();
      mockFastAPIRespository = VinttemFastAPIRespository(
        vinttemFastAPIClient: mockVinttemFastAPIClient,
      );
    });

    group('constructor', () {
      test('instantiate FastAPIRepository', () {
        expect(VinttemFastAPIRespository(), isNotNull);
      });
    });

    group('getTranscations', () {
      test('calls getTransactions', () async {
        try {
          await mockFastAPIRespository.getTransactions();
        } catch (_) {}
        verify(() => mockVinttemFastAPIClient.getTransactions()).called(1);
      });

      test('throws exeception when fastAPIClient fails', () async {
        final exception = Exception('something went wrong');

        when(() => mockVinttemFastAPIClient.getTransactions())
            .thenThrow(exception);

        expect(
          () async => mockFastAPIRespository.getTransactions(),
          throwsA(exception),
        );
      });

      test('return a transaction list with success', () async {
        final transaction_1 = MockTransaction();
        when(() => transaction_1.id).thenReturn(1);
        when(() => transaction_1.user)
            .thenReturn(vinttem_fastapi_client.TransactionUser.matheus);
        when(() => transaction_1.value).thenReturn(69.69);
        when(() => transaction_1.category)
            .thenReturn(vinttem_fastapi_client.TransactionCategory.marketStuff);
        when(() => transaction_1.type)
            .thenReturn(vinttem_fastapi_client.TransactionType.proportional);
        when(() => transaction_1.description).thenReturn('fake description 1');

        when(() => mockVinttemFastAPIClient.getTransactions()).thenAnswer(
          (_) async => <vinttem_fastapi_client.Transaction>[transaction_1],
        );

        final actual = await mockFastAPIRespository.getTransactions();

        expect(
          actual,
          <Transaction>[
            const Transaction(
              id: 1,
              user: TransactionUser.matheus,
              value: 69.69,
              category: TransactionCategory.marketStuff,
              type: TransactionType.proportional,
              description: 'fake description 1',
            )
          ],
        );
      });
    });
  });
}
