import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:vinttem_fastapi/vinttem_fastapi.dart' as vinttem_fastapi_client;
import 'package:vinttem_repository/src/models/transaction.dart';
import 'package:vinttem_repository/src/repositories/fastapi_repository.dart';

class MockFastAPITransaction extends Mock
    implements vinttem_fastapi_client.Transaction {}

class MockTransaction extends Mock implements Transaction {}

class MockVinttemFastAPIClient extends Mock
    implements vinttem_fastapi_client.VinttemFastAPI {}

void main() {
  group('FastAPIRepository', () {
    late vinttem_fastapi_client.VinttemFastAPI mockVinttemFastAPIClient;
    late VinttemFastAPIRespository mockFastAPIRespository;

    late MockFastAPITransaction mockFastAPITransaction;
    late MockTransaction mockRepositoryTransaction;

    setUp(() {
      registerFallbackValue(MockTransaction());
      registerFallbackValue(MockFastAPITransaction());

      mockRepositoryTransaction = MockTransaction();
      mockFastAPITransaction = MockFastAPITransaction();

      mockVinttemFastAPIClient = MockVinttemFastAPIClient();
      mockFastAPIRespository = VinttemFastAPIRespository(
        vinttemFastAPIClient: mockVinttemFastAPIClient,
      );

      when(() => mockFastAPITransaction.user)
          .thenReturn(vinttem_fastapi_client.TransactionUser.matheus);
      when(() => mockFastAPITransaction.value).thenReturn(69.69);
      when(() => mockFastAPITransaction.category)
          .thenReturn(vinttem_fastapi_client.TransactionCategory.marketStuff);
      when(() => mockFastAPITransaction.type)
          .thenReturn(vinttem_fastapi_client.TransactionType.proportional);
      when(() => mockFastAPITransaction.description)
          .thenReturn('fake description 1');
      when(() => mockVinttemFastAPIClient.getTransactions()).thenAnswer(
        (_) async =>
            <vinttem_fastapi_client.Transaction>[mockFastAPITransaction],
      );
    });

    group('constructor', () {
      test('instantiate FastAPIRepository', () {
        expect(VinttemFastAPIRespository(), isNotNull);
      });
    });

    group('getTranscations', () {
      setUp(() {});
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
        final actual = await mockFastAPIRespository.getTransactions();

        expect(
          actual,
          <Transaction>[
            const Transaction(
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

    group('createTransaction', () {
      setUp(() {
        when(() => mockRepositoryTransaction.user)
            .thenReturn(TransactionUser.matheus);
        when(() => mockRepositoryTransaction.value).thenReturn(69.69);
        when(() => mockRepositoryTransaction.category)
            .thenReturn(TransactionCategory.marketStuff);
        when(() => mockRepositoryTransaction.type)
            .thenReturn(TransactionType.proportional);
        when(() => mockRepositoryTransaction.description)
            .thenReturn('fake description 1');
        when(
          () => mockVinttemFastAPIClient.createTransaction(any()),
        ).thenAnswer(
          (_) async => mockFastAPITransaction,
        );
      });

      test('calls createTransaction', () async {
        try {
          await mockFastAPIRespository
              .createTransaction(mockRepositoryTransaction);
        } catch (_) {}
        verify(
          () => mockVinttemFastAPIClient.createTransaction(any()),
        ).called(1);
      });

      test('throws exeception when fastAPIClient fails', () async {
        final exception = Exception('something went wrong');

        when(
          () => mockVinttemFastAPIClient.createTransaction(any()),
        ).thenThrow(exception);

        expect(
          () async => mockFastAPIRespository
              .createTransaction(mockRepositoryTransaction),
          throwsA(exception),
        );
      });

      test('return a transaction after create one with success', () async {
        final actual = await mockFastAPIRespository
            .createTransaction(mockRepositoryTransaction);

        expect(
          actual,
          const Transaction(
            user: TransactionUser.matheus,
            value: 69.69,
            category: TransactionCategory.marketStuff,
            type: TransactionType.proportional,
            description: 'fake description 1',
          ),
        );
      });
    });

    group('deleteTransaction', () {
      test('calls deleteTransaction', () async {
        try {
          await mockFastAPIRespository.deleteTransaction(1);
        } catch (_) {}
        verify(() => mockVinttemFastAPIClient.deleteTransaction(1)).called(1);
      });
    });
  });
}
