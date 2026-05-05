import 'package:apis_auth_jwt/ApiAuth/api_repository.dart';
import 'package:apis_auth_jwt/Home/home_event.dart';
import 'package:apis_auth_jwt/Home/home_state.dart';
import 'package:apis_auth_jwt/Model/recipes_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiRepository apiRepository;
  int count = 10;

  HomeBloc(this.apiRepository) : super(HomeInitial()) {
    on<RecipesLoadEvent>(onFetchData);
    on<LoadMoreRecipesLoadEvent>(loadMoreRecipesLoad);
  }

  Future<void> onFetchData(RecipesLoadEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final data = await apiRepository.getRecipesList(count.toString(), "0");
      List<RecipesModel> recipesList = [];
      data.data['recipes'].forEach((v) {
        recipesList.add(RecipesModel.fromJson(v));
      });
      emit(HomeSuccess(recipesList, recipesList.length < count));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> loadMoreRecipesLoad(LoadMoreRecipesLoadEvent ecebt, Emitter<HomeState> emit) async {
    if (state is HomeSuccess) {
      final currentState = state as HomeSuccess;

      if (currentState.hasReachedMax) return;

      try {
        final data = await apiRepository.getRecipesList(count.toString(), currentState.recipes.length.toString());
        List<RecipesModel> recipesList = [];
        data.data['recipes'].forEach((v) {
          recipesList.add(RecipesModel.fromJson(v));
        });
        emit(HomeSuccess(currentState.recipes + recipesList, recipesList.length < count));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    }
  }
}
