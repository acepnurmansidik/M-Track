import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/models/user_model.dart';
import 'package:tracking/services/user_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void fetchInitiate() async {
    try {
      emit(UserLoading());
      final userProfile = await UserService().getUserProfile();
      emit(UserSuccess(userProfile: userProfile));
    } catch (e) {
      emit(UserFailed(e.toString()));
    }
  }
}
