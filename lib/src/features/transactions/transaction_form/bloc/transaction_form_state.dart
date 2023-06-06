part of 'transaction_form_bloc.dart';

abstract class TransactionFormState extends Equatable {
  const TransactionFormState();
  
  @override
  List<Object> get props => [];
}

class TransactionFormInitial extends TransactionFormState {}
