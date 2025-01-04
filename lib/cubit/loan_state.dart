part of 'loan_cubit.dart';

sealed class LoanState extends Equatable {
  const LoanState();

  @override
  List<Object> get props => [];
}

final class LoanInitial extends LoanState {}

final class LoanLoading extends LoanState {}

final class LoanSuccesss extends LoanState {
  final List<dynamic> loanList;

  const LoanSuccesss({required this.loanList});

  @override
  List<Object> get props => [loanList];
}

final class LoanFailed extends LoanState {
  final String error;

  const LoanFailed(this.error);

  @override
  List<Object> get props => [error];
}
