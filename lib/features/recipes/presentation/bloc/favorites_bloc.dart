import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/favorites_local_storage.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesLocalStorage localStorage;

  FavoritesBloc({required this.localStorage})
    : super(const FavoritesInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<CheckFavoriteEvent>(_onCheckFavorite);

    // Load favorites on initialization
    add(const LoadFavoritesEvent());
  }

  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());
    try {
      final favorites = await localStorage.getFavorites();
      final favoriteIds = favorites
          .where((meal) => meal.idMeal != null)
          .map((meal) => meal.idMeal!)
          .toSet();

      emit(FavoritesLoaded(favorites: favorites, favoriteIds: favoriteIds));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onAddFavorite(
    AddFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      final success = await localStorage.saveFavorite(event.meal);
      if (success) {
        // Reload favorites
        add(const LoadFavoritesEvent());
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      final success = await localStorage.removeFavorite(event.mealId);
      if (success) {
        // Reload favorites
        add(const LoadFavoritesEvent());
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    if (currentState is FavoritesLoaded) {
      final isFavorite = currentState.isFavorite(event.meal.idMeal ?? '');
      if (isFavorite) {
        // Remove favorite
        try {
          final success = await localStorage.removeFavorite(event.meal.idMeal ?? '');
          if (success) {
            add(const LoadFavoritesEvent());
          }
        } catch (e) {
          emit(FavoritesError(e.toString()));
        }
      } else {
        // Add favorite
        try {
          final success = await localStorage.saveFavorite(event.meal);
          if (success) {
            add(const LoadFavoritesEvent());
          }
        } catch (e) {
          emit(FavoritesError(e.toString()));
        }
      }
    } else {
      // If state is not loaded, just add
      try {
        final success = await localStorage.saveFavorite(event.meal);
        if (success) {
          add(const LoadFavoritesEvent());
        }
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    }
  }

  Future<void> _onCheckFavorite(
    CheckFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    // This event is handled by the state's isFavorite method
    // No state change needed, just reload to update UI
    add(const LoadFavoritesEvent());
  }
}
