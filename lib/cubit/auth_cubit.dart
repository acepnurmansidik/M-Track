import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tracking/models/auth_model.dart';
import 'package:tracking/services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signup(body) async {
    try {
      emit(AuthLoading());
      await AuthService().authRegister(body);
      emit(AuthRegisterSuccess());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signIn(body) async {
    try {
      emit(AuthLoading());
      final auth = await AuthService().authLogin(body);

      // save token to storage
      AndroidOptions getAndroidOptions() => const AndroidOptions(
            encryptedSharedPreferences: true,
          );
      final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
      await storage.write(key: 'token', value: auth.token);

      emit(AuthLoginSuccess(auth));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
