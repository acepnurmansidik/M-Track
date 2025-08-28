import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/models/refparameter_model.dart';
import 'package:tracking/services/reffparam_service.dart';

part 'reffparam_state.dart';

class ReffparamCubit extends Cubit<ReffparamState> {
  ReffparamCubit() : super(ReffparamInitial());

  void fetchReffParam() async {
    try {
      emit(ReffparamLoading());
      final result = await ReffparamService().getReffParam();
      emit(ReffparamSuccess(result));
    } catch (e) {
      emit(ReffparamFailed(e.toString()));
    }
  }
}
