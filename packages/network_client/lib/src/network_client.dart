import 'package:http/http.dart' as http;

class NetworkClientError implements Exception {
  NetworkClientError(this.statusCode, this.message, this.stackTrace);

  final int statusCode;
  final String message;
  final StackTrace stackTrace;
}

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

typedef GetCall = Future<http.Response> Function(
  Uri, {
  Map<String, String>? headers,
});

class NetworkClient {
  const NetworkClient();
}
