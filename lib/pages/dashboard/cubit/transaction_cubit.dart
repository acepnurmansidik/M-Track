import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/models/categories_model.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:tracking/services/transaction_service.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  void fetchInitiate() async {
    try {
      emit(TransactionLoading());
      final transactionPeriode =
          await TransactionService().getPeriodeTransaction();
      final categoryTransaction = await TransactionService().getCategories();
      final listItemTransaction =
          await TransactionService().getTransactionList();

      emit(TransactionSuccess(
        categoryTransaction: categoryTransaction,
        listItemTransaction: listItemTransaction,
        transactionPeriode: transactionPeriode,
      ));
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }

  void createTransaction(body) async {
    try {
      emit(TransactionLoading());
      await TransactionService().postTransaction(body);
      emit(TransactionActionSuccess());
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }

  void updateTransaction(id, body) async {
    try {
      emit(TransactionLoading());
      await TransactionService().putTransaction(id, body);
      emit(TransactionActionSuccess());
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }
}
