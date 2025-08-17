part of 'category_activity_cubit.dart';

sealed class CategoryActivityState extends Equatable {
  const CategoryActivityState();

  @override
  List<Object> get props => [];
}

final class CategoryActivityInitial extends CategoryActivityState {}

final class CategoryActivityLoading extends CategoryActivityState {}

final class CategoryActivitySuccess extends CategoryActivityState {}
