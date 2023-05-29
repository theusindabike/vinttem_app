import 'package:vinttem_repository/vinttem_repository.dart';

class VinttemMockRepository implements VinttemRepository {
  @override
  Future<List<Transaction>> getTransactions() async {
    return <Transaction>[
      const Transaction(
        id: 'fake_id_1',
        user: TransactionUser.matheus,
        value: 123.45,
        category: TransactionCategory.marketStuff,
        type: TransactionType.even,
        description: 'fake description 1',
      ),
      const Transaction(
        id: 'fake_id_2',
        user: TransactionUser.matheus,
        value: 23.45,
        category: TransactionCategory.cloths,
        type: TransactionType.proportinal,
        description: 'fake description 2',
      ),
      const Transaction(
        id: 'fake_id_3',
        user: TransactionUser.matheus,
        value: 45.67,
        category: TransactionCategory.gifts,
        type: TransactionType.justMe,
        description: 'fake description 3',
      ),
    ];
  }
}
