import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/models/dashboard_model.dart';
import 'package:tracking/services/dashboard_service.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  void fetchActivityCategory() async {
    try {
      emit(DashboardLoading());
      // call service service dashboard at section activity category
      final dActivityCategory = await DashboardService().getActivityCategory();

      emit(DashboardSuccess(dActivityCategory));
    } catch (e) {
      emit(DashboardFailed(e.toString()));
    }
  }
}
