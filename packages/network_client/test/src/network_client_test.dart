import 'dart:io';

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
  // ignore: flutter_style_todos, flutter_style_todos
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

    group('get', () {
      test('return the response', () async {
        final response = await networkClient.get('/');

        expect(response.statusCode, expectedResponse.statusCode);
        expect(response.body, expectedResponse.body);
      });

      test('sends request with queryParameters correctly', () async {
        await networkClient.get(
          '/some/beutifull/endpoint',
          queryParameters: {
            'param1': 'value1',
            'param2': 'value2',
          },
        );

        verify(
          () => mockHttpClient.get(
            Uri.parse(
              '$baseUrl/some/beutifull/endpoint?param1=value1&param2=value2',
            ),
            headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
          ),
        ).called(1);
      });
    });

    group('post', () {
      test('return the response', () async {
        final response = await networkClient.post('/');

        expect(response.statusCode, expectedResponse.statusCode);
        expect(response.body, expectedResponse.body);
      });

      test('sends request with queryParameters and body correctly', () async {
        await networkClient.post(
          '/some/beutifull/endpoint',
          queryParameters: {
            'param1': 'value1',
            'param2': 'value2',
          },
          body: 'SOME_AMAZING_BODY',
        );

        verify(
          () => mockHttpClient.post(
            Uri.parse(
              '$baseUrl/some/beutifull/endpoint?param1=value1&param2=value2',
            ),
            headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
            body: 'SOME_AMAZING_BODY',
          ),
        ).called(1);
      });
    });

    group('put', () {
      test('return the response', () async {
        final response = await networkClient.put('/');

        expect(response.statusCode, expectedResponse.statusCode);
        expect(response.body, expectedResponse.body);
      });

      test('sends request with queryParameters and body correctly', () async {
        await networkClient.put(
          '/some/beutifull/endpoint',
          queryParameters: {
            'param1': 'value1',
            'param2': 'value2',
          },
          body: 'SOME_AMAZING_BODY',
        );

        verify(
          () => mockHttpClient.put(
            Uri.parse(
              '$baseUrl/some/beutifull/endpoint?param1=value1&param2=value2',
            ),
            headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
            body: 'SOME_AMAZING_BODY',
          ),
        ).called(1);
      });
    });

    group('patch', () {
      test('return the response', () async {
        final response = await networkClient.patch('/');

        expect(response.statusCode, expectedResponse.statusCode);
        expect(response.body, expectedResponse.body);
      });

      test('sends request with queryParameters and body correctly', () async {
        await networkClient.patch(
          '/some/beutifull/endpoint',
          queryParameters: {
            'param1': 'value1',
            'param2': 'value2',
          },
          body: 'SOME_AMAZING_BODY',
        );

        verify(
          () => mockHttpClient.patch(
            Uri.parse(
              '$baseUrl/some/beutifull/endpoint?param1=value1&param2=value2',
            ),
            headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
            body: 'SOME_AMAZING_BODY',
          ),
        ).called(1);
      });
    });

    group('delete', () {
      test('return the response', () async {
        final response = await networkClient.delete('/');

        expect(response.statusCode, expectedResponse.statusCode);
        expect(response.body, expectedResponse.body);
      });

      test('sends request with queryParameters and body correctly', () async {
        await networkClient.delete(
          '/some/beutifull/endpoint',
          body: 'SOME_AMAZING_BODY',
        );

        verify(
          () => mockHttpClient.delete(
            Uri.parse(
              '$baseUrl/some/beutifull/endpoint',
            ),
            headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
            body: 'SOME_AMAZING_BODY',
          ),
        ).called(1);
      });
    });
  });
}
