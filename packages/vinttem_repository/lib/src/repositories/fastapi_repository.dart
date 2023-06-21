import 'package:vinttem_fastapi/vinttem_fastapi.dart' as vinttem_fastapi_client;
import 'package:vinttem_repository/vinttem_repository.dart';

class VinttemFastAPIRespository implements VinttemRepository {
  VinttemFastAPIRespository({
    vinttem_fastapi_client.VinttemFastAPI? vinttemFastAPIClient,
  }) : _vinttemFastAPIClient =
            vinttemFastAPIClient ?? vinttem_fastapi_client.VinttemFastAPI();

  final vinttem_fastapi_client.VinttemFastAPI _vinttemFastAPIClient;
  late List<Transaction> result;

  @override
  Future<List<Transaction>> getTransactions() async {
    try {
      final transactions = await _vinttemFastAPIClient.getTransactions();
      result = [];
      for (final t in transactions) {
        result.add(
          Transaction(
            user: TransactionUser.values.byName(t.user.name),
            value: t.value,
            type: TransactionType.values.byName(t.type.name),
            category: TransactionCategory.values.byName(t.category.name),
            description: t.description,
          ),
        );
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Transaction> createTransaction(Transaction transactionCreate) async {
    final parsedTransaction = vinttem_fastapi_client.Transaction(
      user: vinttem_fastapi_client.TransactionUser.values
          .byName(transactionCreate.user.name),
      value: transactionCreate.value,
      category: vinttem_fastapi_client.TransactionCategory.values
          .byName(transactionCreate.category.name),
      type: vinttem_fastapi_client.TransactionType.values
          .byName(transactionCreate.type.name),
      description: transactionCreate.description,
    );
    try {
      final result =
          await _vinttemFastAPIClient.createTransaction(parsedTransaction);

      return Transaction(
          user: TransactionUser.values.byName(result.user.name),
          value: result.value,
          category: TransactionCategory.values.byName(result.category.name),
          type: TransactionType.values.byName(result.type.name),
          description: result.description);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTransaction(int transactionId) async {
    try {
      _vinttemFastAPIClient.deleteTransaction(transactionId);
    } catch (_) {
      rethrow;
    }
  }
}
