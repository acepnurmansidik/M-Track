part of 'wallet_cubit.dart';

sealed class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

final class WalletInitial extends WalletState {}

final class WalletLoading extends WalletState {}

final class WalletSuccess extends WalletState {
  final WalletDaum userWallets;

  const WalletSuccess({required this.userWallets});

  @override
  List<Object> get props => [userWallets];
}

final class WalletFailed extends WalletState {
  final String error;

  const WalletFailed(this.error);

  @override
  List<Object> get props => [error];
}
