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
      emit(WalletSuccess(userWallets: result.data[0]));
    } catch (e) {
      emit(WalletFailed(e.toString()));
    }
  }
}
