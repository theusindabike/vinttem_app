import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinttem_repository/vinttem_repository.dart'
    as vinttem_repository;

part 'transactions_list_event.dart';
part 'transactions_list_state.dart';

class TransactionsListBloc
    extends Bloc<TransactionsListEvent, TransactionsListState> {
  TransactionsListBloc({
    required vinttem_repository.VinttemRepository vinttemRepository,
  })  : _vinttemRepository = vinttemRepository,
        super(const TransactionsListState()) {
    on<TransactionsListRequested>(_onListTransactionsRequested);
  }

  final vinttem_repository.VinttemRepository _vinttemRepository;

  Future<void> _onListTransactionsRequested(
    TransactionsListRequested event,
    Emitter<TransactionsListState> emit,
  ) async {
    emit(state.copyWith(status: TransactionsListStatus.loading));

    try {
      final transactions = await _vinttemRepository.getTransactions();

      emit(
        state.copyWith(
          status: TransactionsListStatus.success,
          transactions: transactions,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: TransactionsListStatus.failure));
    }
  }
}
