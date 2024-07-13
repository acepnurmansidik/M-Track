import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/services/transaction_service.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  void fetchTransaction() async {
    try {
      emit(TransactionLoading());
      final result = await TransactionService().getTransactions();

      emit(TransactionSuccess(result));
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }
}
