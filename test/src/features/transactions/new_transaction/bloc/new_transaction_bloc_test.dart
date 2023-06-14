import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vinttem_app/src/features/transactions/new_transaction/new_transaction.dart';
import 'package:vinttem_app/src/features/transactions/transaction.dart'
    hide Transaction, TransactionCategory, TransactionType, TransactionUser;
import 'package:vinttem_repository/vinttem_repository.dart'
    as vinttem_repository;

class MockVinttemRepository extends Mock
    implements vinttem_repository.VinttemRepository {}

class FakeTransaction extends Fake implements vinttem_repository.Transaction {}

void main() {
  late vinttem_repository.VinttemRepository mockVinttemRepository;
  const fakeTransaction = vinttem_repository.Transaction(
    id: 1,
    user: vinttem_repository.TransactionUser.bianca,
    value: 6.66,
    category: vinttem_repository.TransactionCategory.cloths,
    type: vinttem_repository.TransactionType.even,
  );

  setUpAll(() {
    registerFallbackValue(FakeTransaction());
  });

  setUp(() {
    mockVinttemRepository = MockVinttemRepository();
  });

  NewTransactionBloc buildBloc() =>
      NewTransactionBloc(vinttemRepository: mockVinttemRepository);

  group('NewTransactionBloc', () {
    test('initial state is NewTransactionState', () {
      expect(buildBloc().state, const NewTransactionState());
    });
  });

  group('NewTransactionSubmitted', () {
    blocTest<NewTransactionBloc, NewTransactionState>(
      'emits [newTransactionInProgress, newTransactionCreated] '
      'when newTransaction succeeds',
      setUp: () {
        when(
          () => mockVinttemRepository.createTransaction(
            any(),
          ),
        ).thenAnswer(
          (_) => Future<vinttem_repository.Transaction>.value(fakeTransaction),
        );
      },
      build: buildBloc,
      act: (bloc) {
        bloc
          ..add(const NewTransactionUserChanged(user: 'bianca'))
          ..add(const NewTransactionValueChanged(value: 6.66))
          ..add(const NewTransactionSubmitted());
      },
      expect: () => const <NewTransactionState>[
        NewTransactionState(user: NewTransactionUser.dirty('bianca')),
        NewTransactionState(
          user: NewTransactionUser.dirty('bianca'),
          value: NewTransactionValue.dirty(6.66),
          isValid: true,
        ),
        NewTransactionState(
          user: NewTransactionUser.dirty('bianca'),
          value: NewTransactionValue.dirty(6.66),
          isValid: true,
          status: FormzSubmissionStatus.inProgress,
        ),
        NewTransactionState(
          user: NewTransactionUser.dirty('bianca'),
          value: NewTransactionValue.dirty(6.66),
          isValid: true,
          status: FormzSubmissionStatus.success,
        ),
      ],
    );

    blocTest<NewTransactionBloc, NewTransactionState>(
      'emits [newTransactionInProgress, newTransactionFailure] '
      'when newTransaction fails',
      setUp: () {
        when(
          () => mockVinttemRepository.createTransaction(
            any(),
          ),
        ).thenThrow('somenthin went wrong');
      },
      build: buildBloc,
      act: (bloc) {
        bloc
          ..add(const NewTransactionUserChanged(user: 'bianca'))
          ..add(const NewTransactionValueChanged(value: 6.66))
          ..add(const NewTransactionSubmitted());
      },
      expect: () => const <NewTransactionState>[
        NewTransactionState(user: NewTransactionUser.dirty('bianca')),
        NewTransactionState(
          user: NewTransactionUser.dirty('bianca'),
          value: NewTransactionValue.dirty(6.66),
          isValid: true,
        ),
        NewTransactionState(
          user: NewTransactionUser.dirty('bianca'),
          value: NewTransactionValue.dirty(6.66),
          isValid: true,
          status: FormzSubmissionStatus.inProgress,
        ),
        NewTransactionState(
          user: NewTransactionUser.dirty('bianca'),
          value: NewTransactionValue.dirty(6.66),
          isValid: true,
          status: FormzSubmissionStatus.failure,
        ),
      ],
    );
  });
}
