import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/meal_repository.dart';
import '../../data/models/meal_model.dart';
import '../../data/models/filtered_meal_model.dart';
import '../../data/models/category_model.dart';
import 'recipe_event.dart';
import 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final MealRepository repository;

  RecipeBloc({required this.repository}) : super(const RecipeInitial()) {
    on<LoadRecipesEvent>(_onLoadRecipes);
    on<SearchRecipesEvent>(_onSearchRecipes);
    on<FilterByCategoryEvent>(_onFilterByCategory);
    on<FilterByAreaEvent>(_onFilterByArea);
    on<FilterByIngredientEvent>(_onFilterByIngredient);
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<LoadAreasEvent>(_onLoadAreas);
    on<ClearFiltersEvent>(_onClearFilters);
    on<SortRecipesEvent>(_onSortRecipes);
  }

  Future<void> _onLoadRecipes(
    LoadRecipesEvent event,
    Emitter<RecipeState> emit,
  ) async {
    emit(const RecipeLoading());
    try {
      // Load meals to get trending recipes
      final response = await repository.searchMealByName('fruit');
      final categoriesResponse = await repository.getAllCategories();
      final areasResponse = await repository.getAllAreas();

      emit(RecipeLoaded(
        meals: response.meals,
        categories: categoriesResponse.categories,
        areas: areasResponse.items,
      ));
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }

  Future<void> _onSearchRecipes(
    SearchRecipesEvent event,
    Emitter<RecipeState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      // If search is empty, load random meals
      add(const LoadRecipesEvent());
      return;
    }

    emit(const RecipeLoading());
    try {
      final response = await repository.searchMealByName(event.query);
      
      // Get current state to preserve filters
      final currentState = state;
      List<CategoryModel>? categories;
      List<ListItemModel>? areas;
      String? selectedCategory;
      String? selectedArea;
      SortOrder? sortOrder;

      if (currentState is RecipeLoaded) {
        categories = currentState.categories;
        areas = currentState.areas;
        selectedCategory = currentState.selectedCategory;
        selectedArea = currentState.selectedArea;
        sortOrder = currentState.sortOrder;
      } else {
        // Load categories and areas if not already loaded
        final categoriesResponse = await repository.getAllCategories();
        final areasResponse = await repository.getAllAreas();
        categories = categoriesResponse.categories;
        areas = areasResponse.items;
      }

      emit(RecipeLoaded(
        meals: response.meals,
        categories: categories,
        areas: areas,
        searchQuery: event.query,
        selectedCategory: selectedCategory,
        selectedArea: selectedArea,
        sortOrder: sortOrder,
      ));
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }

  Future<void> _onFilterByCategory(
    FilterByCategoryEvent event,
    Emitter<RecipeState> emit,
  ) async {
    emit(const RecipeLoading());
    try {
      final response = await repository.filterByCategory(event.category);
      
      // Get current state
      final currentState = state;
      List<ListItemModel>? areas;
      List<CategoryModel>? categories;

      if (currentState is RecipeLoaded) {
        areas = currentState.areas;
        categories = currentState.categories;
      } else {
        final areasResponse = await repository.getAllAreas();
        final categoriesResponse = await repository.getAllCategories();
        areas = areasResponse.items;
        categories = categoriesResponse.categories;
      }

      // Fetch full details for each filtered meal
      final fullMeals = <MealModel>[];
      if (response.meals.isNotEmpty) {
        // Fetch full details in parallel for better performance
        final futures = response.meals
            .where((meal) => meal.idMeal != null)
            .map((meal) => repository.lookupMealById(meal.idMeal!))
            .toList();
        
        final results = await Future.wait(futures);
        for (final result in results) {
          if (result.meals.isNotEmpty) {
            fullMeals.addAll(result.meals);
          }
        }
      }

      emit(RecipeLoaded(
        meals: fullMeals,
        categories: categories,
        areas: areas,
        selectedCategory: event.category,
        selectedArea: null,
      ));
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }

  Future<void> _onFilterByArea(
    FilterByAreaEvent event,
    Emitter<RecipeState> emit,
  ) async {
    emit(const RecipeLoading());
    try {
      final response = await repository.filterByArea(event.area);
      
      // Get current state
      final currentState = state;
      List<CategoryModel>? categories;
      List<ListItemModel>? areas;

      if (currentState is RecipeLoaded) {
        categories = currentState.categories;
        areas = currentState.areas;
      } else {
        final categoriesResponse = await repository.getAllCategories();
        final areasResponse = await repository.getAllAreas();
        categories = categoriesResponse.categories;
        areas = areasResponse.items;
      }

      // Fetch full details for each filtered meal
      final fullMeals = <MealModel>[];
      if (response.meals.isNotEmpty) {
        // Fetch full details in parallel for better performance
        final futures = response.meals
            .where((meal) => meal.idMeal != null)
            .map((meal) => repository.lookupMealById(meal.idMeal!))
            .toList();
        
        final results = await Future.wait(futures);
        for (final result in results) {
          if (result.meals.isNotEmpty) {
            fullMeals.addAll(result.meals);
          }
        }
      }

      emit(RecipeLoaded(
        meals: fullMeals,
        categories: categories,
        areas: areas,
        selectedCategory: null,
        selectedArea: event.area,
      ));
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }

  Future<void> _onFilterByIngredient(
    FilterByIngredientEvent event,
    Emitter<RecipeState> emit,
  ) async {
    emit(const RecipeLoading());
    try {
      final response = await repository.filterByIngredient(event.ingredient);
      emit(FilteredMealsLoaded(
        meals: response.meals,
      ));
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }

  Future<void> _onLoadCategories(
    LoadCategoriesEvent event,
    Emitter<RecipeState> emit,
  ) async {
    try {
      final response = await repository.getAllCategories();
      
      // Preserve current state
      final currentState = state;
      if (currentState is RecipeLoaded) {
        emit(currentState.copyWith(categories: response.categories));
      } else {
        emit(RecipeLoaded(
          meals: const [],
          categories: response.categories,
        ));
      }
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }

  Future<void> _onLoadAreas(
    LoadAreasEvent event,
    Emitter<RecipeState> emit,
  ) async {
    try {
      final response = await repository.getAllAreas();
      
      // Preserve current state
      final currentState = state;
      if (currentState is RecipeLoaded) {
        emit(currentState.copyWith(areas: response.items));
      } else {
        emit(RecipeLoaded(
          meals: const [],
          areas: response.items,
        ));
      }
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }

  Future<void> _onClearFilters(
    ClearFiltersEvent event,
    Emitter<RecipeState> emit,
  ) async {
    // Load random meals to reset
    add(const LoadRecipesEvent());
  }

  Future<void> _onSortRecipes(
    SortRecipesEvent event,
    Emitter<RecipeState> emit,
  ) async {
    final currentState = state;
    if (currentState is RecipeLoaded) {
      final sortedMeals = List<MealModel>.from(currentState.meals);
      sortedMeals.sort((a, b) {
        final nameA = a.strMeal ?? '';
        final nameB = b.strMeal ?? '';
        if (event.sortOrder == SortOrder.aToZ) {
          return nameA.compareTo(nameB);
        } else {
          return nameB.compareTo(nameA);
        }
      });

      emit(currentState.copyWith(
        meals: sortedMeals,
        sortOrder: event.sortOrder,
      ));
    } else if (currentState is FilteredMealsLoaded) {
      final sortedMeals = List<FilteredMealModel>.from(currentState.meals);
      sortedMeals.sort((a, b) {
        final nameA = a.strMeal ?? '';
        final nameB = b.strMeal ?? '';
        if (event.sortOrder == SortOrder.aToZ) {
          return nameA.compareTo(nameB);
        } else {
          return nameB.compareTo(nameA);
        }
      });

      emit(FilteredMealsLoaded(
        meals: sortedMeals,
        selectedCategory: currentState.selectedCategory,
        selectedArea: currentState.selectedArea,
      ));
    }
  }
}
