part of 'refparamater_cubit.dart';

sealed class RefparamaterState extends Equatable {
  const RefparamaterState();

  @override
  List<Object> get props => [];
}

final class RefparamaterInitial extends RefparamaterState {}

final class RefparamaterLoading extends RefparamaterState {}

final class RefparamaterSuccess extends RefparamaterState {
  final List<dynamic> refparam;

  const RefparamaterSuccess(this.refparam);

  @override
  List<Object> get props => [refparam];
}

final class RefparamaterFailed extends RefparamaterState {
  final String error;

  const RefparamaterFailed(this.error);

  @override
  List<Object> get props => [error];
}
