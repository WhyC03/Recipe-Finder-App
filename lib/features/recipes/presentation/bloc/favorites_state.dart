import 'package:equatable/equatable.dart';
import '../../data/models/meal_model.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

// Initial state
class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

// Loading state
class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

// Loaded state
class FavoritesLoaded extends FavoritesState {
  final List<MealModel> favorites;
  final Set<String> favoriteIds; // For quick lookup

  const FavoritesLoaded({
    required this.favorites,
    required this.favoriteIds,
  });

  @override
  List<Object?> get props => [favorites, favoriteIds];

  bool isFavorite(String mealId) {
    return favoriteIds.contains(mealId);
  }
}

// Error state
class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}
