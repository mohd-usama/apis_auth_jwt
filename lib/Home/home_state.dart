import 'package:apis_auth_jwt/Model/recipes_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  List<RecipesModel> recipes=[];
  bool hasReachedMax;
  HomeSuccess(this.recipes,this.hasReachedMax);
}

class HomeError extends HomeState {
  String error;
  HomeError(this.error);
}
