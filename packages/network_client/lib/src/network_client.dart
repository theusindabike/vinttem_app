import 'dart:html';

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
}
