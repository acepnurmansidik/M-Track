import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/models/categories_model.dart';
import 'package:tracking/services/transaction_service.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  void fetchGroupCategories() async {
    try {
      emit(TransactionLoading());
      CategoriesModelProps data = await TransactionService().getCategories();
      emit(TransactionSuccess(data));
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }
}
