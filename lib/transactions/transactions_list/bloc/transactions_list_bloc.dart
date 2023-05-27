import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinttem_repository/vinttem_repository.dart' as vinttem_api;

part 'transactions_list_event.dart';
part 'transactions_list_state.dart';

class TransactionsListBloc
    extends Bloc<TransactionsListEvent, TransactionsListState> {
  TransactionsListBloc({
    required vinttem_api.VinttemRepository transactionRepository,
  })  : _transactionRepository = transactionRepository,
        super(const TransactionsListState()) {
    on<TransactionsListSubscriptionRequested>(_onSubscriptionRequested);
  }

  final vinttem_api.VinttemRepository _transactionRepository;

  Future<void> _onSubscriptionRequested(
    TransactionsListSubscriptionRequested event,
    Emitter<TransactionsListState> emit,
  ) async {
    emit(state.copyWith(status: TransactionsListStatus.loading));

    try {
      final transactions = await _transactionRepository.getTransactions();

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
