import 'dart:convert';
import 'dart:io';

import 'package:network_client/network_client.dart';

import 'package:vinttem_repository/vinttem_repository.dart';

class TransactionRequestFailure implements Exception {}

class TransactionNotFoundFailure implements Exception {}

class VinttemFastAPIRepository implements VinttemRepository {
  VinttemFastAPIRepository({required NetworkClient networkClient})
      : _networkClient = networkClient;

  final NetworkClient _networkClient;

  @override
  Future<List<Transaction>> getTransactions() async {
    final response = await _networkClient.get('/');

    if (response.statusCode != HttpStatus.ok) {
      throw NetworkClientError(
        response.statusCode,
        '[GET] / returned status ${response.statusCode} with the following response "${response.body}"',
        StackTrace.current,
      );
    }

    try {
      final transactionsJson =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (!transactionsJson.containsKey('results')) {
        throw NetworkClientError(
          response.statusCode,
          '[GET] / returned status ${response.statusCode} with the following response "${response.body}"',
          StackTrace.current,
        );
      }

      final results = transactionsJson['results'] as List;

      if (results.isEmpty) return List<Transaction>.empty();

      return results
          .map((item) => Transaction.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw NetworkClientError(
        response.statusCode,
        '[GET] / returned invalid response "${response.body}"',
        StackTrace.current,
      );
    }
  }

  @override
  Future<Transaction> createTransaction(Transaction transaction) async {
    final jsonData = transaction.toJson();

    final response = await _networkClient.post(
      '/',
      body: jsonData,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw NetworkClientError(
        response.statusCode,
        '[POST] / returned status ${response.statusCode} with the following response "${response.body}"',
        StackTrace.current,
      );
    }
    try {
      final transactionJson = jsonDecode(response.body) as Map<String, dynamic>;
      return Transaction.fromJson(transactionJson);
    } catch (e) {
      throw NetworkClientError(
        response.statusCode,
        '[POST] / returned invalid response "${response.body}"',
        StackTrace.current,
      );
    }
  }

  @override
  Future<void> deleteTransaction(int transactionId) async {
    final response = await _networkClient.delete(
      '/',
    );

    if (response.statusCode != HttpStatus.ok) {
      throw NetworkClientError(
        response.statusCode,
        '[DELETE] / returned status ${response.statusCode} with the following response "${response.body}"',
        StackTrace.current,
      );
    }
  }
}
