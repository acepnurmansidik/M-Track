part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final UserModelProps userProfile;

  const UserSuccess({required this.userProfile});

  @override
  List<Object> get props => [userProfile];
}

final class UserFailed extends UserState {
  final String error;

  const UserFailed(this.error);

  @override
  List<Object> get props => [error];
}
