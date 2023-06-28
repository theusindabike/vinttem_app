import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:network_client/network_client.dart';
import 'package:test/test.dart';

class _MockHttpClient extends Mock {
  Future<http.Response> get(Uri uri, {Map<String, String>? headers});
  Future<http.Response> post(
    Uri uri, {
    Object? body,
    Map<String, String>? headers,
  });
  Future<http.Response> put(
    Uri uri, {
    Object? body,
    Map<String, String>? headers,
  });
  Future<http.Response> patch(
    Uri uri, {
    Object? body,
    Map<String, String>? headers,
  });
  Future<http.Response> delete(
    Uri uri, {
    Object? body,
    Map<String, String>? headers,
  });
}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri.parse('http://localhost'));
  });
  group('NetworkClient', () {
    const baseUrl = 'http://baseurl.com';

    final responseJson = {'key': 'value'};
    final expectedResponse = http.Response(responseJson.toString(), 200);

    late NetworkClient networkClient;
    late _MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = _MockHttpClient();

      when(
        () => mockHttpClient.get(
          any(),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => expectedResponse);

      when(
        () => mockHttpClient.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => expectedResponse);

      when(
        () => mockHttpClient.put(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => expectedResponse);

      when(
        () => mockHttpClient.patch(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => expectedResponse);

      when(
        () => mockHttpClient.delete(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => expectedResponse);

      networkClient = NetworkClient(
        baseUrl: baseUrl,
        getCall: mockHttpClient.get,
        postCall: mockHttpClient.post,
        putCall: mockHttpClient.put,
        patchCall: mockHttpClient.patch,
        deleteCall: mockHttpClient.delete,
      );
    });

    test('can be instantiated', () {
      expect(
        NetworkClient(
          baseUrl: 'http://localhost',
        ),
        isNotNull,
      );
    });
  });
}
