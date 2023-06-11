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
    on<UserChanged>(_onTransactionUserChanged);
    on<ValueChanged>(_onTransactionValueChanged);
    on<NewTransactionSubmitted>(_onTransactionSubmitted);
  }

  final vinttem_repository.VinttemRepository _vinttemRepository;

  void _onTransactionUserChanged(
    UserChanged event,
    Emitter<NewTransactionState> emit,
  ) {
    final user = NewTransactionUser.dirty(event.user);

    emit(
      state.copyWith(
        user: user,
        isValid: Formz.validate([state.value, user]),
      ),
    );
  }

  void _onTransactionValueChanged(
    ValueChanged event,
    Emitter<NewTransactionState> emit,
  ) {
    final value = NewTransactionValue.dirty(event.value);

    emit(
      state.copyWith(
        value: value,
        isValid: Formz.validate([state.user, value]),
      ),
    );
  }

  Future<void> _onTransactionSubmitted(
    NewTransactionSubmitted event,
    Emitter<NewTransactionState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _vinttemRepository.getTransactions();
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
