import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:vinttem_fastapi/vinttem_fastapi.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('VinttemFastapi', () {
    late http.Client httpClient;
    late VinttemFastAPI vinttemFastAPI;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });
    setUp(() {
      httpClient = MockHttpClient();
      vinttemFastAPI = VinttemFastAPI(httpClient: httpClient);
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
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await vinttemFastAPI.getTransactions();
        } catch (_) {}

        verify(
          () => httpClient.get(
            Uri.http('127.0.0.1:8000', '/api/v1/transactions/'),
          ),
        ).called(1);
      });

      test('throws TransactionRequestFailure on non-200 request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(405);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        expect(
          vinttemFastAPI.getTransactions(),
          throwsA(isA<TransactionRequestFailure>()),
        );
      });

      test('throws TransactionNotFoundFailure on results empty', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"results": []}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        expect(
          vinttemFastAPI.getTransactions(),
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
                "id": "fake_id_1",
                "user": "matheus",
                "value": 123.45,
                "category": "marketStuff",
                "type": "even",
                "description": "fake description 1"
              }
            ]
          }
          ''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final request = await vinttemFastAPI.getTransactions();

        expect(
          request.first,
          isA<Transaction>()
              .having((t) => t.id, 'id', 'fake_id_1')
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
