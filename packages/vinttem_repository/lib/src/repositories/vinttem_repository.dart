import 'package:vinttem_repository/src/models/models.dart';

// ignore: one_member_abstracts
abstract class VinttemRepository {
  Future<List<Transaction>> getTransactions();
}
