import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:vinttem_app/src/features/transactions/transaction_form/models/models.dart';

part 'transaction_form_event.dart';
part 'transaction_form_state.dart';

class TransactionFormBloc
    extends Bloc<TransactionFormEvent, TransactionFormState> {
  TransactionFormBloc() : super(const TransactionFormState()) {
    on<TransactionFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
