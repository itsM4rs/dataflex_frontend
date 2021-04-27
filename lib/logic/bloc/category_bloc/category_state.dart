part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  CategoryLoaded({this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoryRefreshing extends CategoryState {}

class CategoryError extends CategoryState {
  final String message;

  CategoryError({this.message});

  @override
  List<Object> get props => [message];
}
