import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/services/refparameter_service.dart';

part 'refparamater_state.dart';

class RefparamaterCubit extends Cubit<RefparamaterState> {
  RefparamaterCubit() : super(RefparamaterInitial());

  void getRefparam({parentId = ""}) async {
    try {
      emit(RefparamaterLoading());

      final listCategoryTypeReff = await RefparameterService()
          .fetchListParameter(url: '?type=cashflow_type');

      if (listCategoryTypeReff.isNotEmpty) {
        parentId = listCategoryTypeReff[0].id;
      }

      final listCategoryReff = await RefparameterService()
          .fetchListParameter(url: '?type=category&parent_id=$parentId');

      emit(RefparamaterSuccess(
        listCategoryTypeReff: listCategoryTypeReff,
        listCategoryReff: listCategoryReff,
      ));
    } catch (e) {
      emit(RefparamaterFailed(e.toString()));
    }
  }

  void refreshCategory({parentId = ""}) async {
    final state = this.state;
    try {
      emit(RefparamaterLoading());

      final listCategoryReff = await RefparameterService()
          .fetchListParameter(url: '?type=category&parent_id=$parentId');

      if (state is RefparamaterSuccess) {
        emit(RefparamaterSuccess(
          listCategoryTypeReff: state.listCategoryTypeReff,
          listCategoryReff: listCategoryReff,
        ));
      }
    } catch (e) {
      emit(RefparamaterFailed(e.toString()));
    }
  }

  void createNewTransaction(body) async {
    try {
      emit(RefparamaterLoading());
      // call post fucn at service
      await RefparameterService().createNewReffparam(body);
      emit(ReffparameterCreateSuccess());
    } catch (e) {
      emit(RefparamaterFailed(e.toString()));
    }
  }
}
