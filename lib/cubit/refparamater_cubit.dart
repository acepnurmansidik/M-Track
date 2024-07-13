import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/services/refparameter_service.dart';

part 'refparamater_state.dart';

class RefparamaterCubit extends Cubit<RefparamaterState> {
  RefparamaterCubit() : super(RefparamaterInitial());

  void getRefparam() async {
    try {
      emit(RefparamaterLoading());
      final result = await RefparameterService().fetchListParameter();
      emit(RefparamaterSuccess(result));
    } catch (e) {
      emit(RefparamaterFailed(e.toString()));
    }
  }
}
