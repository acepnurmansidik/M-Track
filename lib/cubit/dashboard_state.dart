part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardSuccess extends DashboardState {
  final ActivityCategoryModel activityCategory;

  const DashboardSuccess(this.activityCategory);

  @override
  List<Object> get props => [activityCategory];
}

final class DashboardFailed extends DashboardState {
  final String error;

  const DashboardFailed(this.error);

  @override
  List<Object> get props => [error];
}
