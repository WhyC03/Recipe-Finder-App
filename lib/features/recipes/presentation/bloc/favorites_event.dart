import 'package:equatable/equatable.dart';
import '../../data/models/meal_model.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

// Load all favorites
class LoadFavoritesEvent extends FavoritesEvent {
  const LoadFavoritesEvent();
}

// Add a favorite
class AddFavoriteEvent extends FavoritesEvent {
  final MealModel meal;

  const AddFavoriteEvent(this.meal);

  @override
  List<Object?> get props => [meal];
}

// Remove a favorite
class RemoveFavoriteEvent extends FavoritesEvent {
  final String mealId;

  const RemoveFavoriteEvent(this.mealId);

  @override
  List<Object?> get props => [mealId];
}

// Toggle favorite (add if not exists, remove if exists)
class ToggleFavoriteEvent extends FavoritesEvent {
  final MealModel meal;

  const ToggleFavoriteEvent(this.meal);

  @override
  List<Object?> get props => [meal];
}

// Check if a meal is favorite
class CheckFavoriteEvent extends FavoritesEvent {
  final String mealId;

  const CheckFavoriteEvent(this.mealId);

  @override
  List<Object?> get props => [mealId];
}
