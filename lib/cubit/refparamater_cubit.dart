import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/services/refparameter_service.dart';

part 'refparamater_state.dart';

class RefparamaterCubit extends Cubit<RefparamaterState> {
  RefparamaterCubit() : super(RefparamaterInitial());

  void getRefparam() async {
    try {
      emit(RefparamaterLoading());

      final reffCategory = await RefparameterService()
          .fetchListParameter(queryType: "category", preserve: true);

      final reffKurs = await RefparameterService()
          .fetchListParameter(queryType: "kurs", preserve: true);

      emit(RefparamaterSuccess(reffKurs: reffKurs, refparam: reffCategory));
    } catch (e) {
      emit(RefparamaterFailed(e.toString()));
    }
  }
}
