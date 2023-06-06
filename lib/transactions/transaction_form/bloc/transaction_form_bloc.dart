import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'transaction_form_event.dart';
part 'transaction_form_state.dart';

class TransactionFormBloc extends Bloc<TransactionFormEvent, TransactionFormState> {
  TransactionFormBloc() : super(TransactionFormInitial()) {
    on<TransactionFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
