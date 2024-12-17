import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:tracking/services/transaction_service.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  void fetchTransaction() async {
    try {
      emit(TransactionLoading());
      TransactionModel result = await TransactionService().getTransactions();

      emit(TransactionSuccess(result));
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }

  void postTrx(body) async {
    try {
      emit(TransactionLoading());
      await TransactionService().createTrx(body);
      emit(TransactionCreateSuccess());
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }

  void putTrx(String id, Map<String, dynamic> body) async {
    try {
      emit(TransactionLoading());
      await TransactionService().updateTrx(id, body);
      emit(TransactionCreateSuccess());
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }

  void deleteTrx(String id) async {
    try {
      emit(TransactionLoading());
      await TransactionService().destroyTrx(id);
      // fetch data kembali setelah di hapus
      final result = await TransactionService().getTransactions();
      emit(TransactionSuccess(result));
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }
}
