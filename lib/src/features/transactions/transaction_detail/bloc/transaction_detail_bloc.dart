import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:vinttem_app/src/features/transactions/transaction.dart';
import 'package:vinttem_repository/vinttem_repository.dart'
    as vinttem_repository;

part 'transaction_detail_event.dart';
part 'transaction_detail_state.dart';

class TransactionDetailBloc
    extends Bloc<TransactionDetailEvent, TransactionDetailState> {
  TransactionDetailBloc({
    required vinttem_repository.VinttemRepository vinttemRepository,
  })  : _vinttemRepository = vinttemRepository,
        super(const TransactionDetailState()) {
    on<TransactionDetailUserChanged>(_onTransactionUserChanged);
    on<TransactionDetailValueChanged>(_onTransactionValueChanged);
    on<TransactionDetailCategoryChanged>(_onTransactionCategoryChanged);
    on<TransactionDetailTypeChanged>(_onTransactionTypeChanged);
    on<TransactionDetailDescriptionChanged>(_onTransactionDescriptionChanged);
    on<TransactionDetailFormCleaned>(_onTransactionDetailFormCleaned);
    on<TransactionDetailSubmitted>(_onTransactionSubmitted);
  }

  final vinttem_repository.VinttemRepository _vinttemRepository;

  void _onTransactionUserChanged(
    TransactionDetailUserChanged event,
    Emitter<TransactionDetailState> emit,
  ) {
    final user = TransactionDetailUser.dirty(event.user);

    emit(
      state.copyWith(
        user: user,
        isValid: Formz.validate([
          user,
          state.value,
          state.category,
          state.type,
        ]),
      ),
    );
  }

  void _onTransactionValueChanged(
    TransactionDetailValueChanged event,
    Emitter<TransactionDetailState> emit,
  ) {
    final value = TransactionDetailValue.dirty(event.value);

    emit(
      state.copyWith(
        value: value,
        isValid: Formz.validate([
          state.user,
          value,
          state.category,
          state.type,
        ]),
      ),
    );
  }

  void _onTransactionCategoryChanged(
    TransactionDetailCategoryChanged event,
    Emitter<TransactionDetailState> emit,
  ) {
    final category = TransactionDetailCategory.dirty(event.category);

    emit(
      state.copyWith(
        category: category,
        isValid: Formz.validate([
          state.user,
          state.value,
          category,
          state.type,
        ]),
      ),
    );
  }

  void _onTransactionTypeChanged(
    TransactionDetailTypeChanged event,
    Emitter<TransactionDetailState> emit,
  ) {
    final type = TransactionDetailType.dirty(event.type);

    emit(
      state.copyWith(
        type: type,
        isValid: Formz.validate([
          state.user,
          state.value,
          state.category,
          type,
        ]),
      ),
    );
  }

  void _onTransactionDescriptionChanged(
    TransactionDetailDescriptionChanged event,
    Emitter<TransactionDetailState> emit,
  ) {
    final description = TransactionDetailDescription.dirty(event.description);

    emit(
      state.copyWith(
        description: description,
        isValid: Formz.validate([
          state.user,
          state.value,
          state.category,
          state.type,
        ]),
      ),
    );
  }

  void _onTransactionDetailFormCleaned(
    TransactionDetailFormCleaned event,
    Emitter<TransactionDetailState> emit,
  ) {
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        user: const TransactionDetailUser.pure(),
        value: const TransactionDetailValue.pure(),
        category: const TransactionDetailCategory.pure(),
        type: const TransactionDetailType.pure(),
        description: const TransactionDetailDescription.pure(),
        isValid: false,
      ),
    );
  }

  Future<void> _onTransactionSubmitted(
    TransactionDetailSubmitted event,
    Emitter<TransactionDetailState> emit,
  ) async {
    final user = TransactionDetailUser.dirty(state.user.value);
    final value = TransactionDetailValue.dirty(state.value.value);
    final category = TransactionDetailCategory.dirty(state.category.value);
    final type = TransactionDetailType.dirty(state.type.value);
    final description =
        TransactionDetailDescription.dirty(state.description.value);

    final validate = Formz.validate([user, value, category, type]);
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
