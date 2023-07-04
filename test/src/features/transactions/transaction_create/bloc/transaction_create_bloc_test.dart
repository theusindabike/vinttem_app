import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vinttem_app/src/features/transactions/transaction.dart'
    hide Transaction, TransactionCategory, TransactionType, TransactionUser;
import 'package:vinttem_app/src/features/transactions/transaction_create/transaction_create.dart';
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

  TransactionCreateBloc buildBloc() =>
      TransactionCreateBloc(vinttemRepository: mockVinttemRepository);

  group('TransactionCreateBloc', () {
    test('initial state is TransactionCreateState', () {
      expect(buildBloc().state, const TransactionCreateState());
    });
  });

  group('TransactionCreateSubmitted', () {
    blocTest<TransactionCreateBloc, TransactionCreateState>(
      'emits [TransactionCreateInProgress, TransactionCreateCreated] '
      'when submit a TransactionCreate successfully',
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
          ..add(const TransactionCreateUserChanged(user: 'Bianca'))
          ..add(const TransactionCreateValueChanged(value: 6.66))
          ..add(const TransactionCreateCategoryChanged(category: 'Cloths'))
          ..add(const TransactionCreateTypeChanged(type: 'Even'))
          ..add(
            const TransactionCreateDescriptionChanged(
              description: '',
            ),
          )
          ..add(const TransactionCreateSubmitted());
      },
      expect: () => const <TransactionCreateState>[
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          isValid: true,
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          category: TransactionCreateCategory.dirty('Cloths'),
          isValid: true,
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          category: TransactionCreateCategory.dirty('Cloths'),
          type: TransactionCreateType.dirty('Even'),
          isValid: true,
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          category: TransactionCreateCategory.dirty('Cloths'),
          type: TransactionCreateType.dirty('Even'),
          description: TransactionCreateDescription.dirty(),
          isValid: true,
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          category: TransactionCreateCategory.dirty('Cloths'),
          type: TransactionCreateType.dirty('Even'),
          description: TransactionCreateDescription.dirty(),
          isValid: true,
          status: FormzSubmissionStatus.inProgress,
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          category: TransactionCreateCategory.dirty('Cloths'),
          type: TransactionCreateType.dirty('Even'),
          description: TransactionCreateDescription.dirty(),
          isValid: true,
          status: FormzSubmissionStatus.success,
        ),
      ],
    );

    blocTest<TransactionCreateBloc, TransactionCreateState>(
      'emits [TransactionCreateInProgress, TransactionCreateFailure] '
      'when TransactionCreate fails',
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
          ..add(const TransactionCreateUserChanged(user: 'Bianca'))
          ..add(const TransactionCreateValueChanged(value: 6.66))
          ..add(const TransactionCreateCategoryChanged(category: 'Cloths'))
          ..add(const TransactionCreateTypeChanged(type: 'Even'))
          ..add(const TransactionCreateDescriptionChanged(description: ''))
          ..add(const TransactionCreateSubmitted());
      },
      expect: () => const <TransactionCreateState>[
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          isValid: true,
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          category: TransactionCreateCategory.dirty('Cloths'),
          isValid: true,
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          category: TransactionCreateCategory.dirty('Cloths'),
          type: TransactionCreateType.dirty('Even'),
          isValid: true,
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          category: TransactionCreateCategory.dirty('Cloths'),
          type: TransactionCreateType.dirty('Even'),
          description: TransactionCreateDescription.dirty(),
          isValid: true,
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          category: TransactionCreateCategory.dirty('Cloths'),
          type: TransactionCreateType.dirty('Even'),
          description: TransactionCreateDescription.dirty(),
          isValid: true,
          status: FormzSubmissionStatus.inProgress,
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          category: TransactionCreateCategory.dirty('Cloths'),
          type: TransactionCreateType.dirty('Even'),
          description: TransactionCreateDescription.dirty(),
          isValid: true,
          status: FormzSubmissionStatus.failure,
        ),
      ],
    );
  });

  group('TransactionCreateFormClean', () {
    blocTest<TransactionCreateBloc, TransactionCreateState>(
      'emits [TransactionCreateFormCleaned] '
      'when press Clean Button',
      build: buildBloc,
      act: (bloc) {
        bloc
          ..add(const TransactionCreateUserChanged(user: 'Bianca'))
          ..add(const TransactionCreateValueChanged(value: 6.66))
          ..add(const TransactionCreateCategoryChanged(category: 'Cloths'))
          ..add(const TransactionCreateTypeChanged(type: 'Even'))
          ..add(const TransactionCreateFormCleaned());
      },
      expect: () => const <TransactionCreateState>[
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          isValid: true,
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          category: TransactionCreateCategory.dirty('Cloths'),
          isValid: true,
        ),
        TransactionCreateState(
          user: TransactionCreateUser.dirty('Bianca'),
          value: TransactionCreateValue.dirty(6.66),
          category: TransactionCreateCategory.dirty('Cloths'),
          type: TransactionCreateType.dirty('Even'),
          isValid: true,
        ),
        TransactionCreateState(),
      ],
    );
  });
}
