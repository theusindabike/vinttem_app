import 'package:vinttem_repository/vinttem_repository.dart';

class VinttemMockRepository implements VinttemRepository {
  @override
  Future<List<Transaction>> getTransactions() async {
    return <Transaction>[
      const Transaction(
        id: 1,
        user: TransactionUser.matheus,
        value: 123.45,
        category: TransactionCategory.marketStuff,
        type: TransactionType.even,
        description: 'fake description 1',
      ),
      const Transaction(
        id: 2,
        user: TransactionUser.matheus,
        value: 23.45,
        category: TransactionCategory.cloths,
        type: TransactionType.proportional,
        description: 'fake description 2',
      ),
      const Transaction(
        id: 3,
        user: TransactionUser.matheus,
        value: 45.67,
        category: TransactionCategory.gifts,
        type: TransactionType.individual,
        description: 'fake description 3',
      ),
    ];
  }
}
