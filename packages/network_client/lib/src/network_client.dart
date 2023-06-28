import 'dart:html';
import 'dart:io';

import 'package:http/http.dart' as http;

class NetworkClientError implements Exception {
  NetworkClientError(this.statusCode, this.message, this.stackTrace);

  final int statusCode;
  final String message;
  final StackTrace stackTrace;
}

typedef GetCall = Future<http.Response> Function(
  Uri, {
  Map<String, String>? headers,
});

typedef PostCall = Future<http.Response> Function(
  Uri, {
  Object? body,
  Map<String, String>? headers,
});

typedef PutCall = Future<http.Response> Function(
  Uri, {
  Object? body,
  Map<String, String>? headers,
});

typedef PatchCall = Future<http.Response> Function(
  Uri, {
  Object? body,
  Map<String, String>? headers,
});

typedef DeleteCall = Future<http.Response> Function(
  Uri, {
  Object? body,
  Map<String, String>? headers,
});

class NetworkClient {
  NetworkClient({
    required String baseUrl,
    GetCall getCall = http.get,
    PostCall postCall = http.post,
    PutCall putCall = http.put,
    PatchCall patchCall = http.patch,
    DeleteCall deleteCall = http.delete,
  })  : _baseUrl = Uri.parse(baseUrl),
        _get = getCall,
        _post = postCall,
        _put = putCall,
        _patch = patchCall,
        _delete = deleteCall;

  final Uri _baseUrl;
  final GetCall _get;
  final PostCall _post;
  final PutCall _put;
  final PatchCall _patch;
  final PatchCall _delete;

  Map<String, String> get _headers =>
      {HttpHeaders.contentTypeHeader: ContentType.json.value};

  Future<http.Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _get(
      _baseUrl.replace(
        path: path,
        queryParameters: queryParameters,
      ),
      headers: _headers,
    );
  }

  Future<http.Response> post(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _post(
      _baseUrl.replace(
        path: path,
        queryParameters: queryParameters,
      ),
      body: body,
      headers: _headers,
    );
  }

  Future<http.Response> put(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _put(
      _baseUrl.replace(
        path: path,
        queryParameters: queryParameters,
      ),
      body: body,
      headers: _headers,
    );
  }

  Future<http.Response> patch(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _patch(
      _baseUrl.replace(
        path: path,
        queryParameters: queryParameters,
      ),
      body: body,
      headers: _headers,
    );
  }

  Future<http.Response> delete(
    String path, {
    Object? body,
  }) async {
    return _delete(
      _baseUrl.replace(
        path: path,
      ),
      body: body,
      headers: _headers,
    );
  }
}
