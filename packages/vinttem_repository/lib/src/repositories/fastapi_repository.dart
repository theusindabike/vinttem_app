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
            id: t.id,
            value: t.value,
            description: t.description,
            type: TransactionType.values.byName(t.type.name),
            category: TransactionCategory.values.byName(t.category.name),
            user: TransactionUser.values.byName(t.user.name),
          ),
        );
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Transaction> createTransaction(Transaction newTransaction) async {
    final parsedTransaction = vinttem_fastapi_client.Transaction(
      id: 1,
      user: vinttem_fastapi_client.TransactionUser.values
          .byName(newTransaction.user.name),
      value: newTransaction.value,
      category: vinttem_fastapi_client.TransactionCategory.values
          .byName(newTransaction.category.name),
      type: vinttem_fastapi_client.TransactionType.values
          .byName(newTransaction.type.name),
      description: newTransaction.description,
    );
    try {
      final result =
          await _vinttemFastAPIClient.createTransaction(parsedTransaction);

      return Transaction(
        id: result.id,
        user: TransactionUser.values.byName(result.user.name),
        value: result.value,
        category: TransactionCategory.values.byName(result.category.name),
        type: TransactionType.values.byName(result.type.name),
      );
    } catch (e) {
      rethrow;
    }
  }
}
