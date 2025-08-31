import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/services/action_service.dart';

part 'action_delete_state.dart';

class ActionDeleteCubit extends Cubit<ActionDeleteState> {
  ActionDeleteCubit() : super(const ActionDeleteInitial());

  void activate(String newPath) {
    emit(state.copyWith(isActive: true, path: newPath));
  }

  void deactivate() {
    emit(state.copyWith(isActive: false, path: ''));
  }

  Future<void> deleteData() async {
    try {
      emit(ActionDeleteLoading(isActive: true, path: state.path));
      await ActionService().delete(state.path);
      emit(const ActionDeleteSuccess(isActive: false, path: ''));
    } catch (e) {
      emit(ActionDeleteFailed(e.toString(), isActive: false, path: ''));
    }
  }
}
