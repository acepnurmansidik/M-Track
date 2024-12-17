// ignore_for_file: must_be_immutable

part of 'refparamater_cubit.dart';

sealed class RefparamaterState extends Equatable {
  const RefparamaterState();

  @override
  List<Object> get props => [];

  get listCategoryTypeReff => null;
}

final class RefparamaterInitial extends RefparamaterState {}

final class RefparamaterLoading extends RefparamaterState {}

final class ReffparameterCreateSuccess extends RefparamaterState {}

final class RefparamaterSuccess extends RefparamaterState {
  @override
  final List<dynamic> listCategoryTypeReff;
  final List<dynamic> listCategoryReff;

  late String parentID;

  RefparamaterSuccess({
    required this.listCategoryTypeReff,
    required this.listCategoryReff,
  });

  @override
  List<Object> get props => [listCategoryTypeReff, listCategoryReff];
}

final class RefparamaterFailed extends RefparamaterState {
  final String error;

  const RefparamaterFailed(this.error);

  @override
  List<Object> get props => [error];
}
