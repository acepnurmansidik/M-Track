import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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

      emit(AuthLoginSuccess(auth));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void checkToken(BuildContext context) async {
    try {
      emit(AuthLoading());
      await AuthService().authLoginChecked(context);
      emit(AuthCheckToken());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut(BuildContext context) async {
    try {
      emit(AuthLoading());
      await AuthService().authLogOut(context);
      emit(AuthSignOutToken());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
