import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/services/refparameter_service.dart';

part 'refparamater_state.dart';

class RefparamaterCubit extends Cubit<RefparamaterState> {
  RefparamaterCubit() : super(RefparamaterInitial());

  void getRefparamTypeCategory() async {
    try {
      emit(RefparamaterLoading());
      final result = await RefparameterService().fetchListParameter("category");
      emit(RefparamaterSuccess(result));
    } catch (e) {
      emit(RefparamaterFailed(e.toString()));
    }
  }

  void getRefKurs() async {
    try {
      emit(RefparamaterLoading());
      final result = await RefparameterService().fetchListParameter("kurs");
      emit(RefparamaterSuccess(result));
    } catch (e) {
      emit(RefparamaterFailed(e.toString()));
    }
  }
}
