import 'package:vinttem_repository/src/models/models.dart';

abstract class VinttemRepository {
  Future<List<Transaction>> getTransactions();
  Future<Transaction> createTransaction(String user, double value);
}
