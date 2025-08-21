import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/models/wallet_model.dart';
import 'package:tracking/services/wallet_service.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  void fetchUserWallet() async {
    try {
      emit(WalletLoading());
      final result = await WalletService().getAllWalletUser();

      // sementara disimpan di state, nextnya disimpan di localstorage
      final walletIdSelected = result.data[0].id;

      emit(WalletSuccess(
        walletSelected: result.data
            .where((everyItem) => everyItem.id == walletIdSelected)
            .toList()[0],
        userWallets: result.data,
        walleIdSelected: walletIdSelected,
      ));
    } catch (e) {
      emit(WalletFailed(e.toString()));
    }
  }
}
