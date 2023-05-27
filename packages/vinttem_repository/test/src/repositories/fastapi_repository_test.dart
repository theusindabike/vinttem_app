import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:vinttem_fastapi/vinttem_fastapi.dart' as vinttem_fastapi_client;
import 'package:vinttem_repository/src/repositories/fastapi_repository.dart';

class MockTransaction extends Mock
    implements vinttem_fastapi_client.Transaction {}

class MockVinttemFastAPIClient extends Mock
    implements vinttem_fastapi_client.VinttemFastAPI {}

void main() {
  group('FastAPIRepository', () {
    late vinttem_fastapi_client.VinttemFastAPI mockVinttemFastAPIClient;
    late VinttemFastAPIRespository fastAPIRespository;

    setUp(() {
      mockVinttemFastAPIClient = MockVinttemFastAPIClient();
      fastAPIRespository = VinttemFastAPIRespository(
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
          await fastAPIRespository.getTransactions();
        } catch (_) {}
        verify(() => mockVinttemFastAPIClient.getTransactions()).called(1);
      });
    });
  });
}
