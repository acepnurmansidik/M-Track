import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/model/transaction_model.dart';
import 'package:tracking/service/transaction_service.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  void fetchTransaction() async {
    try {
      emit(TransactionLoading());
      final response = await TransactionService().getTransactions();
      emit(TransactionSuccess(response));
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }
}
