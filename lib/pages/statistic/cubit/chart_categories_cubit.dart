import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/models/chart_categories_periode_model.dart';
import 'package:tracking/services/chart_category_service.dart';

part 'chart_categories_state.dart';

class ChartCategoriesCubit extends Cubit<ChartCategoriesState> {
  ChartCategoriesCubit() : super(ChartCategoriesInitial());

  void fetchInitate(String periodeFilter) async {
    try {
      emit(ChartCategoriesLoading());
      final categoryPeriode =
          await ChartCategoryService().getChartCategoriesPeriode(periodeFilter);
      emit(ChartCategoriesSuccess(categoryPeriode: categoryPeriode));
    } catch (e) {
      emit(ChartCategoriesFailed(e.toString()));
    }
  }
}
