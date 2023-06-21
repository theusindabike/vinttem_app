import 'package:dio/dio.dart' as http;

import 'package:vinttem_fastapi/src/models/models.dart';

class TransactionRequestFailure implements Exception {}

class TransactionNotFoundFailure implements Exception {}

class VinttemFastAPI {
  VinttemFastAPI({http.Dio? httpClient})
      : _httpClient = httpClient ?? http.Dio();

  static const _vinttemFastAPIBaseURL = '10.0.2.2:8000';
  static const _vinttemFastAPIPrefixURL = '/api/v1/';

  final http.Dio _httpClient;

  Future<List<Transaction>> getTransactions() async {
    try {
      final uri = Uri.http(
        _vinttemFastAPIBaseURL,
        '${_vinttemFastAPIPrefixURL}transactions/',
      );

      final response = await _httpClient.getUri<Map<String, dynamic>>(uri);

      if (response.statusCode != 200) throw TransactionRequestFailure();

      final transactionsJson = response.data!;

      if (!transactionsJson.containsKey('results')) {
        throw TransactionNotFoundFailure();
      }

      final results = transactionsJson['results'] as List;

      if (results.isEmpty) throw TransactionNotFoundFailure();

      return results
          .map((item) => Transaction.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Transaction> createTransaction(Transaction transaction) async {
    try {
      final uri = Uri.http(
        _vinttemFastAPIBaseURL,
        '${_vinttemFastAPIPrefixURL}transactions/',
      );

      final jsonData = transaction.toJson();

      final response = await _httpClient.postUri<Map<String, dynamic>>(
        uri,
        data: jsonData,
      );

      if (response.statusCode != 200) throw TransactionRequestFailure();

      final transactionJson = response.data!;

      return Transaction.fromJson(transactionJson);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTransaction(int transactionId) async {
    try {
      final uri = Uri.http(
        _vinttemFastAPIBaseURL,
        '${_vinttemFastAPIPrefixURL}transactions/$transactionId',
      );

      final response = await _httpClient.deleteUri<void>(
        uri,
      );

      if (response.statusCode != 200) throw TransactionRequestFailure();
    } catch (e) {
      rethrow;
    }
  }
}
