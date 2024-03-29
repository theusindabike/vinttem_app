import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

part 'transactions_list_event.dart';
part 'transactions_list_state.dart';

class TransactionsListBloc
    extends Bloc<TransactionsListEvent, TransactionsListState> {
  TransactionsListBloc({
    required VinttemRepository vinttemRepository,
  })  : _vinttemRepository = vinttemRepository,
        super(const TransactionsListState()) {
    on<TransactionsListRequested>(_onTransactionsListRequested);
    on<TransactionsListDeleteRequested>(_onTransactionsListDeleteRequested);
  }

  final VinttemRepository _vinttemRepository;

  Future<void> _onTransactionsListRequested(
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
    } catch (e) {
      emit(state.copyWith(status: TransactionsListStatus.failure));
    }
  }

  Future<void> _onTransactionsListDeleteRequested(
    TransactionsListDeleteRequested event,
    Emitter<TransactionsListState> emit,
  ) async {
    try {
      await _vinttemRepository.deleteTransaction(event.transactionId);
    } catch (e) {
      emit(state.copyWith(status: TransactionsListStatus.failure));
    }
  }
}
