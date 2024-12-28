part of 'wallet_cubit.dart';

sealed class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

final class WalletInitial extends WalletState {}

final class WalletLoading extends WalletState {}

final class WalletFetchSuccess extends WalletState {
  final List<dynamic> listWallet;

  const WalletFetchSuccess({required this.listWallet});

  @override
  List<Object> get props => [listWallet];
}

final class WalletFailed extends WalletState {
  final String error;

  const WalletFailed(this.error);

  @override
  List<Object> get props => [error];
}
