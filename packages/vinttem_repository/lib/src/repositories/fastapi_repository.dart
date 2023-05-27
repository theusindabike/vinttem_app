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

      for (final t in transactions) {
        result.add(Transaction.fromJson(t as Map<String, dynamic>));
      }

      return result;
    } catch (e) {
      print(e.toString());
      throw Error();
    }
  }
}
