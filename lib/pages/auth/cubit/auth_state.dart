part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthCheckToken extends AuthState {}

final class AuthSignOutToken extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  final AuthModelProps auth;

  const AuthLoginSuccess(this.auth);

  @override
  List<Object> get props => [auth];
}

final class AuthRegisterSuccess extends AuthState {}

final class AuthFailed extends AuthState {
  final String error;

  const AuthFailed(this.error);

  @override
  List<Object> get props => [error];
}
