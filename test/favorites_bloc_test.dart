import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder_app/features/recipes/data/datasources/favorites_local_storage.dart';
import 'package:recipe_finder_app/features/recipes/data/models/meal_model.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/favorites_bloc.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/favorites_event.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/favorites_state.dart';

// Mock Local Storage
class MockFavoritesLocalStorage implements FavoritesLocalStorage {
  List<MealModel> _favorites = [];
  Exception? shouldThrow;

  @override
  Future<List<MealModel>> getFavorites() async {
    if (shouldThrow != null) throw shouldThrow!;
    await Future.delayed(const Duration(milliseconds: 10));
    return List.from(_favorites);
  }

  @override
  Future<bool> saveFavorite(MealModel meal) async {
    if (shouldThrow != null) throw shouldThrow!;
    if (!_favorites.any((fav) => fav.idMeal == meal.idMeal)) {
      _favorites.add(meal);
    }
    return true;
  }

  @override
  Future<bool> removeFavorite(String mealId) async {
    if (shouldThrow != null) throw shouldThrow!;
    _favorites.removeWhere((fav) => fav.idMeal == mealId);
    return true;
  }

  @override
  Future<bool> isFavorite(String mealId) async {
    if (shouldThrow != null) throw shouldThrow!;
    return _favorites.any((fav) => fav.idMeal == mealId);
  }

  void clear() {
    _favorites.clear();
  }
}

void main() {
  group('FavoritesBloc Tests', () {
    late FavoritesBloc bloc;
    late MockFavoritesLocalStorage mockStorage;

    setUp(() {
      mockStorage = MockFavoritesLocalStorage();
      bloc = FavoritesBloc(localStorage: mockStorage);
    });

    tearDown(() {
      bloc.close();
      mockStorage.clear();
    });

    test('initial state transitions to FavoritesLoaded after initialization', () async {
      // The bloc automatically loads favorites on initialization
      await Future.delayed(const Duration(milliseconds: 50));
      expect(bloc.state, isA<FavoritesLoaded>());
    });

    group('LoadFavoritesEvent', () {
      test('emits FavoritesLoading then FavoritesLoaded when successful', () async {
        // Arrange
        final testMeal = MealModel(idMeal: '1', strMeal: 'Test Meal');
        mockStorage.saveFavorite(testMeal);
        await Future.delayed(const Duration(milliseconds: 10));

        // Act & Assert
        final expectedStates = [
          isA<FavoritesLoading>(),
          isA<FavoritesLoaded>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expectedStates));

        bloc.add(const LoadFavoritesEvent());
        await Future.delayed(const Duration(milliseconds: 50));
      });

      test('emits FavoritesLoading then FavoritesError when storage throws', () async {
        // Arrange - Create a new bloc with error-throwing storage to test error handling
        final errorStorage = MockFavoritesLocalStorage();
        errorStorage.shouldThrow = Exception('Storage error');
        final errorBloc = FavoritesBloc(localStorage: errorStorage);

        // Wait for initial load (which will fail)
        await Future.delayed(const Duration(milliseconds: 100));

        // Reset shouldThrow and test again
        errorStorage.shouldThrow = Exception('Storage error');

        // Act & Assert
        final expectedStates = [
          isA<FavoritesLoading>(),
          isA<FavoritesError>(),
        ];

        expectLater(errorBloc.stream, emitsInOrder(expectedStates));

        errorBloc.add(const LoadFavoritesEvent());
        await Future.delayed(const Duration(milliseconds: 100));

        errorBloc.close();
      });
    });

    group('AddFavoriteEvent', () {
      test('adds favorite and reloads favorites list', () async {
        // Arrange
        final testMeal = MealModel(idMeal: '1', strMeal: 'New Favorite');
        await Future.delayed(const Duration(milliseconds: 50)); // Wait for initial load

        // Act
        bloc.add(AddFavoriteEvent(testMeal));
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        final state = bloc.state;
        expect(state, isA<FavoritesLoaded>());
        if (state is FavoritesLoaded) {
          expect(state.favoriteIds.contains('1'), true);
        }
      });
    });

    group('RemoveFavoriteEvent', () {
      test('removes favorite and reloads favorites list', () async {
        // Arrange
        final testMeal = MealModel(idMeal: '1', strMeal: 'Test Meal');
        await mockStorage.saveFavorite(testMeal);
        await Future.delayed(const Duration(milliseconds: 50)); // Wait for initial load

        // Act
        bloc.add(const RemoveFavoriteEvent('1'));
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        final state = bloc.state;
        expect(state, isA<FavoritesLoaded>());
        if (state is FavoritesLoaded) {
          expect(state.favoriteIds.contains('1'), false);
        }
      });
    });

    group('ToggleFavoriteEvent', () {
      test('adds favorite when meal is not favorited', () async {
        // Arrange
        final testMeal = MealModel(idMeal: '1', strMeal: 'Test Meal');
        await Future.delayed(const Duration(milliseconds: 50)); // Wait for initial load

        // Act
        bloc.add(ToggleFavoriteEvent(testMeal));
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        final state = bloc.state;
        expect(state, isA<FavoritesLoaded>());
        if (state is FavoritesLoaded) {
          expect(state.favoriteIds.contains('1'), true);
        }
      });

      test('removes favorite when meal is already favorited', () async {
        // Arrange
        final testMeal = MealModel(idMeal: '1', strMeal: 'Test Meal');
        await mockStorage.saveFavorite(testMeal);
        await Future.delayed(const Duration(milliseconds: 100)); // Wait for initial load

        // Act
        bloc.add(ToggleFavoriteEvent(testMeal));
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        final state = bloc.state;
        expect(state, isA<FavoritesLoaded>());
        if (state is FavoritesLoaded) {
          expect(state.favoriteIds.contains('1'), false);
        }
      });
    });

    group('FavoritesLoaded state', () {
      test('isFavorite returns true when meal is in favorites', () async {
        // Arrange
        final testMeal = MealModel(idMeal: '1', strMeal: 'Test');
        await mockStorage.saveFavorite(testMeal);
        await Future.delayed(const Duration(milliseconds: 100));

        // Act
        final state = bloc.state;

        // Assert
        expect(state, isA<FavoritesLoaded>());
        if (state is FavoritesLoaded) {
          expect(state.isFavorite('1'), true);
          expect(state.isFavorite('2'), false);
        }
      });
    });
  });
}
