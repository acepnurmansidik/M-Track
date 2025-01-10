import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/services/loan_service.dart';

part 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  LoanCubit() : super(LoanInitial());

  void getIndexLoan() async {
    try {
      emit(LoanLoading());
      final result = await LoanService().fetchLoanIndex();
      emit(LoanSuccesss(loanList: result));
    } catch (e) {
      emit(LoanFailed(e.toString()));
    }
  }

  void postLoan(body) async {
    try {
      emit(LoanLoading());
      await LoanService().createNewLoan(body);
      final result = await LoanService().fetchLoanIndex();
      emit(LoanSuccesss(loanList: result));
      emit(LoanActionSuccess());
    } catch (e) {
      emit(LoanFailed(e.toString()));
    }
  }

  void puttLoan(body, id) async {
    try {
      emit(LoanLoading());
      await LoanService().updateNewLoan(body, id);
      emit(LoanActionSuccess());
    } catch (e) {
      emit(LoanFailed(e.toString()));
    }
  }
}
