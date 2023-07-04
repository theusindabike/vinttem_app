import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:vinttem_app/src/features/transactions/transaction_create/transaction_create.dart';
import 'package:vinttem_repository/vinttem_repository.dart'
    as vinttem_repository;

part 'transaction_create_event.dart';
part 'transaction_create_state.dart';

class TransactionCreateBloc
    extends Bloc<TransactionCreateEvent, TransactionCreateState> {
  TransactionCreateBloc({
    required vinttem_repository.VinttemRepository vinttemRepository,
  })  : _vinttemRepository = vinttemRepository,
        super(const TransactionCreateState()) {
    on<TransactionCreateUserChanged>(_onTransactionUserChanged);
    on<TransactionCreateValueChanged>(_onTransactionValueChanged);
    on<TransactionCreateCategoryChanged>(_onTransactionCategoryChanged);
    on<TransactionCreateTypeChanged>(_onTransactionTypeChanged);
    on<TransactionCreateDescriptionChanged>(_onTransactionDescriptionChanged);
    on<TransactionCreateFormCleaned>(_onTransactionCreateFormCleaned);
    on<TransactionCreateSubmitted>(_onTransactionSubmitted);
  }

  final vinttem_repository.VinttemRepository _vinttemRepository;

  void _onTransactionUserChanged(
    TransactionCreateUserChanged event,
    Emitter<TransactionCreateState> emit,
  ) {
    final user = TransactionCreateUser.dirty(event.user);

    emit(
      state.copyWith(
        user: user,
        isValid: Formz.validate([
          user,
          state.value,
          state.category,
          state.type,
          state.description,
        ]),
      ),
    );
  }

  void _onTransactionValueChanged(
    TransactionCreateValueChanged event,
    Emitter<TransactionCreateState> emit,
  ) {
    final value = TransactionCreateValue.dirty(event.value);

    emit(
      state.copyWith(
        value: value,
        isValid: Formz.validate([
          state.user,
          value,
          state.category,
          state.type,
          state.description,
        ]),
      ),
    );
  }

  void _onTransactionCategoryChanged(
    TransactionCreateCategoryChanged event,
    Emitter<TransactionCreateState> emit,
  ) {
    final category = TransactionCreateCategory.dirty(event.category);

    emit(
      state.copyWith(
        category: category,
        isValid: Formz.validate([
          state.user,
          state.value,
          category,
          state.type,
          state.description,
        ]),
      ),
    );
  }

  void _onTransactionTypeChanged(
    TransactionCreateTypeChanged event,
    Emitter<TransactionCreateState> emit,
  ) {
    final type = TransactionCreateType.dirty(event.type);

    emit(
      state.copyWith(
        type: type,
        isValid: Formz.validate([
          state.user,
          state.value,
          state.category,
          type,
          state.description,
        ]),
      ),
    );
  }

  void _onTransactionDescriptionChanged(
    TransactionCreateDescriptionChanged event,
    Emitter<TransactionCreateState> emit,
  ) {
    final description = TransactionCreateDescription.dirty(event.description);

    emit(
      state.copyWith(
        description: description,
        isValid: Formz.validate([
          state.user,
          state.value,
          state.category,
          state.type,
          description,
        ]),
      ),
    );
  }

  void _onTransactionCreateFormCleaned(
    TransactionCreateFormCleaned event,
    Emitter<TransactionCreateState> emit,
  ) {
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        user: const TransactionCreateUser.pure(),
        value: const TransactionCreateValue.pure(),
        category: const TransactionCreateCategory.pure(),
        type: const TransactionCreateType.pure(),
        description: const TransactionCreateDescription.pure(),
        isValid: false,
      ),
    );
  }

  Future<void> _onTransactionSubmitted(
    TransactionCreateSubmitted event,
    Emitter<TransactionCreateState> emit,
  ) async {
    final user = TransactionCreateUser.dirty(state.user.value);
    final value = TransactionCreateValue.dirty(state.value.value);
    final category = TransactionCreateCategory.dirty(state.category.value);
    final type = TransactionCreateType.dirty(state.type.value);
    final description =
        TransactionCreateDescription.dirty(state.description.value);

    final validate = Formz.validate([user, value, category, type, description]);
    emit(
      state.copyWith(
        user: user,
        value: value,
        category: category,
        type: type,
        description: description,
        isValid: validate,
      ),
    );

    if (validate) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _vinttemRepository.createTransaction(
          vinttem_repository.Transaction(
            user: vinttem_repository.TransactionUser.getByName(
              state.user.value,
            ),
            value: state.value.value,
            category: vinttem_repository.TransactionCategory.getByName(
              state.category.value,
            ),
            type: vinttem_repository.TransactionType.getByName(
              state.type.value,
            ),
            description: state.description.value,
          ),
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
