import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object?> get props => [];
}

// Load initial recipes
class LoadRecipesEvent extends RecipeEvent {
  const LoadRecipesEvent();
}

// Search recipes by name
class SearchRecipesEvent extends RecipeEvent {
  final String query;

  const SearchRecipesEvent(this.query);

  @override
  List<Object?> get props => [query];
}

// Filter by category
class FilterByCategoryEvent extends RecipeEvent {
  final String category;

  const FilterByCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

// Filter by area
class FilterByAreaEvent extends RecipeEvent {
  final String area;

  const FilterByAreaEvent(this.area);

  @override
  List<Object?> get props => [area];
}

// Filter by ingredient
class FilterByIngredientEvent extends RecipeEvent {
  final String ingredient;

  const FilterByIngredientEvent(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

// Load categories
class LoadCategoriesEvent extends RecipeEvent {
  const LoadCategoriesEvent();
}

// Load areas
class LoadAreasEvent extends RecipeEvent {
  const LoadAreasEvent();
}

// Clear filters
class ClearFiltersEvent extends RecipeEvent {
  const ClearFiltersEvent();
}

// Sort recipes
class SortRecipesEvent extends RecipeEvent {
  final SortOrder sortOrder;

  const SortRecipesEvent(this.sortOrder);

  @override
  List<Object?> get props => [sortOrder];
}

enum SortOrder { aToZ, zToA }
