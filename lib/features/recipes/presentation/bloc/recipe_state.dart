import 'package:equatable/equatable.dart';
import '../../data/models/meal_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/filtered_meal_model.dart';
import 'recipe_event.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object?> get props => [];
}

// Initial state
class RecipeInitial extends RecipeState {
  const RecipeInitial();
}

// Loading state
class RecipeLoading extends RecipeState {
  const RecipeLoading();
}

// Loaded state
class RecipeLoaded extends RecipeState {
  final List<MealModel> meals;
  final List<CategoryModel>? categories;
  final List<ListItemModel>? areas;
  final String? searchQuery;
  final String? selectedCategory;
  final String? selectedArea;
  final SortOrder? sortOrder;

  const RecipeLoaded({
    required this.meals,
    this.categories,
    this.areas,
    this.searchQuery,
    this.selectedCategory,
    this.selectedArea,
    this.sortOrder,
  });

  RecipeLoaded copyWith({
    List<MealModel>? meals,
    List<CategoryModel>? categories,
    List<ListItemModel>? areas,
    String? searchQuery,
    String? selectedCategory,
    String? selectedArea,
    SortOrder? sortOrder,
  }) {
    return RecipeLoaded(
      meals: meals ?? this.meals,
      categories: categories ?? this.categories,
      areas: areas ?? this.areas,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedArea: selectedArea ?? this.selectedArea,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  List<Object?> get props => [
        meals,
        categories,
        areas,
        searchQuery,
        selectedCategory,
        selectedArea,
        sortOrder,
      ];
}

// Error state
class RecipeError extends RecipeState {
  final String message;

  const RecipeError(this.message);

  @override
  List<Object?> get props => [message];
}

// Filtered meals loaded (from filter endpoints)
class FilteredMealsLoaded extends RecipeState {
  final List<FilteredMealModel> meals;
  final String? selectedCategory;
  final String? selectedArea;

  const FilteredMealsLoaded({
    required this.meals,
    this.selectedCategory,
    this.selectedArea,
  });

  @override
  List<Object?> get props => [meals, selectedCategory, selectedArea];
}
