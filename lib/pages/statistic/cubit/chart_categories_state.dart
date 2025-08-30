part of 'chart_categories_cubit.dart';

sealed class ChartCategoriesState extends Equatable {
  const ChartCategoriesState();

  @override
  List<Object> get props => [];
}

final class ChartCategoriesInitial extends ChartCategoriesState {}

final class ChartCategoriesLoading extends ChartCategoriesState {}

final class ChartCategoriesSuccess extends ChartCategoriesState {
  final ChartCategoriesPeriodeProps categoryPeriode;

  const ChartCategoriesSuccess({required this.categoryPeriode});

  @override
  List<Object> get props => [categoryPeriode];
}

final class ChartCategoriesFailed extends ChartCategoriesState {
  final String error;

  const ChartCategoriesFailed(this.error);

  @override
  List<Object> get props => [error];
}
