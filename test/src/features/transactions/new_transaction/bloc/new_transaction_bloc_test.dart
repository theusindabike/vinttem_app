import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vinttem_app/src/features/transactions/new_transaction/bloc/new_transaction_bloc.dart';
import 'package:vinttem_repository/vinttem_repository.dart'
    as vinttem_repository;

class MockVinttemRepository extends Mock
    implements vinttem_repository.VinttemRepository {}

void main() {
  late vinttem_repository.VinttemRepository vinttemRepository;

  setUp(() {
    vinttemRepository = MockVinttemRepository();
  });
  group('NewTransactionBloc', () {
    test('initial state is NewTransactionState', () {
      final newTransactionBloc =
          NewTransactionBloc(vinttemRepository: vinttemRepository);

      expect(newTransactionBloc.state, const NewTransactionState());
    });
  });
}
