part of 'reffparam_cubit.dart';

sealed class ReffparamState extends Equatable {
  const ReffparamState();

  @override
  List<Object> get props => [];
}

final class ReffparamInitial extends ReffparamState {}

final class ReffparamLoading extends ReffparamState {}

final class ReffparamSuccess extends ReffparamState {
  final ReffParamModelProps data;

  const ReffparamSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class ReffparamFailed extends ReffparamState {
  final String error;

  const ReffparamFailed(this.error);

  @override
  List<Object> get props => [error];
}
