import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/models/categories_model.dart';
import 'package:tracking/services/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  void fetchGroupCategories() async {
    try {
      emit(CategoryLoading());
      CategoriesModelProps data = await CategoryService().getCategories();
      emit(CategorySuccess(data));
    } catch (e) {
      emit(CategoryFailed(e.toString()));
    }
  }
}
