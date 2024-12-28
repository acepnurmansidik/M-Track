import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/services/wallet_service.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  void fetchWalletList() async {
    try {
      // send loading
      emit(WalletLoading());

      // fetch data from API
      final response = await WalletService().getListWallet();
      emit(WalletFetchSuccess(listWallet: response));
    } catch (e) {
      emit(WalletFailed(e.toString()));
    }
  }
}
