import 'package:vinttem_fastapi/vinttem_fastapi.dart' as vinttem_fastapi_client
    hide Transaction;
import 'package:vinttem_repository/src/models/transaction.dart';
import 'package:vinttem_repository/src/repositories/repositories.dart';

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
  Future<Transaction> createTransaction(Transaction transaction) async {
    return transaction;
  }
}
