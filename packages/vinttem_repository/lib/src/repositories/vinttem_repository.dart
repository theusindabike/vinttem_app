import 'package:vinttem_repository/src/models/models.dart';

abstract class VinttemRepository {
  Future<List<Transaction>> getTransactions();
  Future<Transaction> createTransaction(Transaction transaction);
  Future<void> deleteTransaction(int transactionId);
}
