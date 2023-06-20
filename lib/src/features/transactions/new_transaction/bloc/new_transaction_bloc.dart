import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:vinttem_app/src/features/transactions/new_transaction/new_transaction.dart';
import 'package:vinttem_repository/vinttem_repository.dart'
    as vinttem_repository;

part 'new_transaction_event.dart';
part 'new_transaction_state.dart';

class NewTransactionBloc
    extends Bloc<NewTransactionEvent, NewTransactionState> {
  NewTransactionBloc({
    required vinttem_repository.VinttemRepository vinttemRepository,
  })  : _vinttemRepository = vinttemRepository,
        super(const NewTransactionState()) {
    on<NewTransactionUserChanged>(_onTransactionUserChanged);
    on<NewTransactionValueChanged>(_onTransactionValueChanged);
    on<NewTransactionCategoryChanged>(_onTransactionCategoryChanged);
    on<NewTransactionSubmitted>(_onTransactionSubmitted);
  }

  final vinttem_repository.VinttemRepository _vinttemRepository;

  void _onTransactionUserChanged(
    NewTransactionUserChanged event,
    Emitter<NewTransactionState> emit,
  ) {
    final user = NewTransactionUser.dirty(event.user);

    emit(
      state.copyWith(
        user: user,
        isValid: Formz.validate([
          user,
          state.value,
          state.category,
        ]),
      ),
    );
  }

  void _onTransactionValueChanged(
    NewTransactionValueChanged event,
    Emitter<NewTransactionState> emit,
  ) {
    final value = NewTransactionValue.dirty(event.value);

    emit(
      state.copyWith(
        value: value,
        isValid: Formz.validate([
          state.user,
          value,
          state.category,
        ]),
      ),
    );
  }

  void _onTransactionCategoryChanged(
    NewTransactionCategoryChanged event,
    Emitter<NewTransactionState> emit,
  ) {
    final category = NewTransactionCategory.dirty(event.category);

    emit(
      state.copyWith(
        category: category,
        isValid: Formz.validate([
          state.user,
          state.value,
          category,
        ]),
      ),
    );
  }

  // void _onTransactionCategoriesChanged(
  //   NewTransactionCategoriesChanged event,
  //   Emitter<NewTransactionState> emit,
  // ) {
  //   final previousSelectedCategories = String>{...state.categories.value};
  //   var categories = NewTransactionCategory.dirty(previousSelectedCategories);

  //   switch (event.action) {
  //     case CategoryAction.insert:
  //       previousSelectedCategories.add(event.category);
  //       categories = NewTransactionCategory.dirty(previousSelectedCategories);
  //     case CategoryAction.remove:
  //       previousSelectedCategories.removeWhere((e) => e == event.category);
  //       categories = NewTransactionCategory.dirty(previousSelectedCategories);
  //     // ignore: no_default_cases
  //     default:
  //       break;
  //   }

  //   emit(
  //     state.copyWith(
  //       categories: categories,
  //       isValid: Formz.validate([
  //         state.user,
  //         state.value,
  //         categories,
  //       ]),
  //     ),
  //   );
  // }

  Future<void> _onTransactionSubmitted(
    NewTransactionSubmitted event,
    Emitter<NewTransactionState> emit,
  ) async {
    final user = NewTransactionUser.dirty(state.user.value);
    final value = NewTransactionValue.dirty(state.value.value);
    final categories = NewTransactionCategory.dirty(state.category.value);

    final validate = Formz.validate([user, value, categories]);
    emit(
      state.copyWith(
        user: user,
        value: value,
        category: categories,
        isValid: validate,
      ),
    );

    if (validate) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _vinttemRepository.createTransaction(
          vinttem_repository.Transaction(
            user:
                vinttem_repository.TransactionUser.getByName(state.user.value),
            value: state.value.value,
            category: vinttem_repository.TransactionCategory.getByName(
              state.category.value,
            ),
            type: vinttem_repository.TransactionType.even,
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
