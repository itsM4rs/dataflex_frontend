import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/category_model.dart';
import '../../../data/repositories/category_repo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  CategoryBloc({this.categoryRepository}) : super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is GetCategories) {
      yield CategoryLoading();
      try {
        final categoriesList = await categoryRepository.fetchCategoriesList();

        if (categoriesList == null) {
          yield CategoryError(message: "Error occured");
        } else {
          yield CategoryLoaded(categories: categoriesList);
        }
      } catch (e) {
        yield CategoryError(message: e.toString());
      }
    }
    if (event is RefreshCategories) {
      yield CategoryLoading();
      try {
        final categoriesList = await categoryRepository.fetchCategoriesList();

        if (categoriesList == null) {
          yield CategoryError(message: "Error occured");
        } else {
          yield CategoryLoaded(categories: categoriesList);
        }
      } catch (e) {
        yield CategoryError(message: e.toString());
      }
    }
  }
}
