import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:vinttem_fastapi/vinttem_fastapi.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

class FakeTransaction extends Fake implements Transaction {}

void main() {
  group('VinttemFastapi', () {
    late http.Client mockHttpClient;
    late VinttemFastAPI mockVinttemFastAPI;

    final fakeTransaction = Transaction(
      id: 1,
      user: TransactionUser.bianca,
      value: 6.66,
      category: TransactionCategory.cloths,
      type: TransactionType.even,
    );

    setUpAll(() {
      registerFallbackValue(FakeUri());
      registerFallbackValue(FakeTransaction());
    });
    setUp(() {
      mockHttpClient = MockHttpClient();
      mockVinttemFastAPI = VinttemFastAPI(httpClient: mockHttpClient);
    });
    group('constructor', () {
      test('can be instantiated without a httpClient', () {
        expect(VinttemFastAPI(), isNotNull);
      });
    });

    group('getTransactions', () {
      test('makes http resquest', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => mockHttpClient.get(any())).thenAnswer((_) async => response);

        try {
          await mockVinttemFastAPI.getTransactions();
        } catch (_) {}

        verify(
          () => mockHttpClient.get(
            Uri.http('10.0.2.2:8000', '/api/v1/transactions/'),
          ),
        ).called(1);
      });

      test('throws TransactionRequestFailure on non-200 request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(405);
        when(() => mockHttpClient.get(any())).thenAnswer((_) async => response);

        expect(
          mockVinttemFastAPI.getTransactions(),
          throwsA(isA<TransactionRequestFailure>()),
        );
      });

      test('throws TransactionNotFoundFailure on results empty', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"results": []}');
        when(() => mockHttpClient.get(any())).thenAnswer((_) async => response);

        expect(
          mockVinttemFastAPI.getTransactions(),
          throwsA(isA<TransactionNotFoundFailure>()),
        );
      });

      test('return a Transction object when valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
          {
            "results": [
              {
                "id": 1,
                "user": "matheus",
                "value": 123.45,
                "category": "marketStuff",
                "type": "even",
                "description": "fake description 1"
              }
            ]
          }
          ''');
        when(() => mockHttpClient.get(any())).thenAnswer((_) async => response);

        final request = await mockVinttemFastAPI.getTransactions();

        expect(
          request.first,
          isA<Transaction>()
              .having((t) => t.id, 'id', 1)
              .having((t) => t.user, 'user', TransactionUser.matheus)
              .having((t) => t.value, 'value', 123.45)
              .having(
                (t) => t.category,
                'category',
                TransactionCategory.marketStuff,
              )
              .having((t) => t.type, 'type', TransactionType.even)
              .having(
                (t) => t.description,
                'description',
                'fake description 1',
              ),
        );
      });
    });

    group('createTransaction', () {
      test('makes http resquest', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(
          () => mockHttpClient.post(any()),
        ).thenAnswer((_) async => response);

        try {
          await mockVinttemFastAPI.createTransaction(fakeTransaction);
        } catch (_) {}

        verify(
          () => mockHttpClient.post(
            Uri.http('10.0.2.2:8000', '/api/v1/transactions/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: fakeTransaction.toJson(),
          ),
        ).called(1);
      });

      test('throws TransactionRequestFailure on non-200 request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(405);
        when(() => mockHttpClient.get(any())).thenAnswer((_) async => response);

        expect(
          mockVinttemFastAPI.getTransactions(),
          throwsA(isA<TransactionRequestFailure>()),
        );
      });

      test('throws TransactionNotFoundFailure on results empty', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"results": []}');
        when(() => mockHttpClient.get(any())).thenAnswer((_) async => response);

        expect(
          mockVinttemFastAPI.getTransactions(),
          throwsA(isA<TransactionNotFoundFailure>()),
        );
      });

      test('return a Transction object when valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
          {
            "results": [
              {
                "id": 1,
                "user": "matheus",
                "value": 123.45,
                "category": "marketStuff",
                "type": "even",
                "description": "fake description 1"
              }
            ]
          }
          ''');
        when(() => mockHttpClient.get(any())).thenAnswer((_) async => response);

        final request = await mockVinttemFastAPI.getTransactions();

        expect(
          request.first,
          isA<Transaction>()
              .having((t) => t.id, 'id', 1)
              .having((t) => t.user, 'user', TransactionUser.matheus)
              .having((t) => t.value, 'value', 123.45)
              .having(
                (t) => t.category,
                'category',
                TransactionCategory.marketStuff,
              )
              .having((t) => t.type, 'type', TransactionType.even)
              .having(
                (t) => t.description,
                'description',
                'fake description 1',
              ),
        );
      });
    });
  });
}
