import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:vinttem_fastapi/src/models/models.dart';

class TransactionRequestFailure implements Exception {}

class TransactionNotFoundFailure implements Exception {}

class VinttemFastAPI {
  VinttemFastAPI({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _vinttemFastAPIBaseURL = '10.0.2.2:8000';
  static const _vinttemFastAPIPrefixURL = '/api/v1/';

  final http.Client _httpClient;

  Future<List<Transaction>> getTransactions() async {
    try {
      final url = Uri.http(
        _vinttemFastAPIBaseURL,
        '${_vinttemFastAPIPrefixURL}transactions/',
      );

      final response = await _httpClient.get(url);

      if (response.statusCode != 200) throw TransactionRequestFailure();

      final transactionsJson =
          jsonDecode(response.body) as Map<String, dynamic>;

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
      final url = Uri.http(
        _vinttemFastAPIBaseURL,
        '${_vinttemFastAPIPrefixURL}transactions/',
      );

      final response = await _httpClient.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: transaction.toJson(),
      );

      if (response.statusCode != 200) throw TransactionRequestFailure();

      final transactionJson = jsonDecode(response.body) as Map<String, dynamic>;

      return Transaction.fromJson(transactionJson);
    } catch (e) {
      rethrow;
    }
  }
}
