part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final dynamic data;

  const CategorySuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class CategoryFailed extends CategoryState {
  final String error;

  const CategoryFailed(this.error);

  @override
  List<Object> get props => [error];
}
