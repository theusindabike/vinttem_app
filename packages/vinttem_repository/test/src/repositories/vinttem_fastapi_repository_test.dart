import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:network_client/network_client.dart';
import 'package:test/test.dart';
import 'package:vinttem_repository/src/models/transaction.dart';
import 'package:vinttem_repository/src/repositories/vinttem_fastapi_repository.dart';

class MockNetworkClient extends Mock implements NetworkClient {}

class MockResponse extends Mock implements http.Response {}

void main() {
  group('FastAPIRepository', () {
    late MockNetworkClient networkClient;
    late VinttemFastAPIRepository vinttemFastAPIRepository;
    late Transaction transaction;
    late http.Response response;

    setUp(() {
      networkClient = MockNetworkClient();
      response = MockResponse();

      vinttemFastAPIRepository = VinttemFastAPIRepository(
        networkClient: networkClient,
      );

      transaction = const Transaction(
        user: TransactionUser.matheus,
        value: 69.69,
        category: TransactionCategory.marketStuff,
        type: TransactionType.proportional,
        description: 'fake description',
      );

      when(
        () => networkClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => response);

      when(
        () => networkClient.post(
          any(),
          queryParameters: any(named: 'queryParameters'),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => response);

      when(
        () => networkClient.delete(
          any(),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => response);
    });

    group('constructor', () {
      test('instantiate VittemFastAPIRepository', () {
        expect(
          VinttemFastAPIRepository(networkClient: networkClient),
          isNotNull,
        );
      });
    });

    group('getTranscations', () {
      setUp(() {});
      test('calls NetworkClient.get', () async {
        try {
          await vinttemFastAPIRepository.getTransactions();
        } catch (_) {}
        verify(() => networkClient.get(any())).called(1);
      });

      test('return a transactions list with success', () async {
        final transactions = List<Transaction>.generate(
          5,
          (_) => transaction,
        );

        when(() => response.statusCode).thenReturn(HttpStatus.ok);
        when(() => response.body).thenReturn(
          jsonEncode({
            'results': transactions.map((e) => e.toJson()).toList(),
          }),
        );

        final actual = await vinttemFastAPIRepository.getTransactions();

        expect(
          actual,
          transactions,
        );
      });

      test('throws NetworkClientExpection when request fails', () async {
        when(() => response.statusCode)
            .thenReturn(HttpStatus.internalServerError);
        when(() => response.body).thenReturn('fake body');

        await expectLater(
          vinttemFastAPIRepository.getTransactions(),
          throwsA(
            isA<NetworkClientError>().having(
              (e) => e.message,
              'message',
              equals(
                '[GET] / returned status 500 with the following response "fake body"',
              ),
            ),
          ),
        );
      });

      test('throws NetworkClientExpection when response body is invalid',
          () async {
        when(() => response.statusCode).thenReturn(HttpStatus.ok);
        when(() => response.body).thenReturn('some invalid body');

        await expectLater(
          vinttemFastAPIRepository.getTransactions(),
          throwsA(
            isA<NetworkClientError>().having(
              (e) => e.message,
              'message',
              equals(
                '[GET] / returned invalid response "some invalid body"',
              ),
            ),
          ),
        );
      });
    });

    group('createTransaction', () {
      setUp(() {});

      test('return a Transaction', () async {
        when(() => response.statusCode).thenAnswer((_) => HttpStatus.ok);
        when(() => response.body).thenReturn(jsonEncode(transaction));

        final actual =
            await vinttemFastAPIRepository.createTransaction(transaction);
        expect(actual, equals(transaction));
      });

      test('throws NetworkClientExpection when request fails', () async {
        when(() => response.statusCode)
            .thenReturn(HttpStatus.internalServerError);
        when(() => response.body).thenReturn('fake body');

        await expectLater(
          vinttemFastAPIRepository.createTransaction(transaction),
          throwsA(
            isA<NetworkClientError>().having(
              (e) => e.message,
              'message',
              equals(
                '[POST] / returned status 500 with the following response "fake body"',
              ),
            ),
          ),
        );
      });

      test('throws NetworkClientExpection when response body is invalid',
          () async {
        when(() => response.statusCode).thenReturn(HttpStatus.ok);
        when(() => response.body).thenReturn('some invalid body');

        await expectLater(
          vinttemFastAPIRepository.createTransaction(transaction),
          throwsA(
            isA<NetworkClientError>().having(
              (e) => e.message,
              'message',
              equals(
                '[POST] / returned invalid response "some invalid body"',
              ),
            ),
          ),
        );
      });
    });

    group('deleteTransaction', () {
      setUp(() {});

      test('throws NetworkClientExpection when request fails', () async {
        when(() => response.statusCode)
            .thenReturn(HttpStatus.internalServerError);
        when(() => response.body).thenReturn('fake body');

        await expectLater(
          vinttemFastAPIRepository.deleteTransaction(1),
          throwsA(
            isA<NetworkClientError>().having(
              (e) => e.message,
              'message',
              equals(
                '[DELETE] / returned status 500 with the following response "fake body"',
              ),
            ),
          ),
        );
      });
    });
  });
}
