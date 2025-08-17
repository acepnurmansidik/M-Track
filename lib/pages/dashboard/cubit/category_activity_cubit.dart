import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_activity_state.dart';

class CategoryActivityCubit extends Cubit<CategoryActivityState> {
  CategoryActivityCubit() : super(CategoryActivityInitial());
}
