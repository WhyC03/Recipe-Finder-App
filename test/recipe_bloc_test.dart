import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder_app/features/recipes/data/models/meal_model.dart';
import 'package:recipe_finder_app/features/recipes/data/models/category_model.dart';
import 'package:recipe_finder_app/features/recipes/data/models/filtered_meal_model.dart';
import 'package:recipe_finder_app/features/recipes/data/repositories/meal_repository.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/recipe_event.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/recipe_state.dart';

// Mock Repository
class MockMealRepository implements MealRepository {
  MealsResponse? mockSearchMealByNameResponse;
  MealsResponse? mockLookupMealByIdResponse;
  MealsResponse? mockGetRandomMealResponse;
  FilteredMealsResponse? mockFilterByCategoryResponse;
  FilteredMealsResponse? mockFilterByAreaResponse;
  FilteredMealsResponse? mockFilterByIngredientResponse;
  CategoriesResponse? mockGetAllCategoriesResponse;
  ListResponse? mockGetAllAreasResponse;
  ListResponse? mockGetCategoryListResponse;

  Exception? shouldThrow;

  @override
  Future<MealsResponse> searchMealByName(String query) async {
    if (shouldThrow != null) throw shouldThrow!;
    return mockSearchMealByNameResponse ?? MealsResponse(meals: []);
  }

  @override
  Future<MealsResponse> lookupMealById(String id) async {
    if (shouldThrow != null) throw shouldThrow!;
    return mockLookupMealByIdResponse ?? MealsResponse(meals: []);
  }

  @override
  Future<MealsResponse> getRandomMeal() async {
    if (shouldThrow != null) throw shouldThrow!;
    return mockGetRandomMealResponse ?? MealsResponse(meals: []);
  }

  @override
  Future<MealsResponse> searchMealByFirstLetter(String letter) async {
    if (shouldThrow != null) throw shouldThrow!;
    return MealsResponse(meals: []);
  }

  @override
  Future<FilteredMealsResponse> filterByCategory(String category) async {
    if (shouldThrow != null) throw shouldThrow!;
    return mockFilterByCategoryResponse ?? FilteredMealsResponse(meals: []);
  }

  @override
  Future<FilteredMealsResponse> filterByArea(String area) async {
    if (shouldThrow != null) throw shouldThrow!;
    return mockFilterByAreaResponse ?? FilteredMealsResponse(meals: []);
  }

  @override
  Future<FilteredMealsResponse> filterByIngredient(String ingredient) async {
    if (shouldThrow != null) throw shouldThrow!;
    return mockFilterByIngredientResponse ?? FilteredMealsResponse(meals: []);
  }

  @override
  Future<CategoriesResponse> getAllCategories() async {
    if (shouldThrow != null) throw shouldThrow!;
    return mockGetAllCategoriesResponse ?? CategoriesResponse(categories: []);
  }

  @override
  Future<ListResponse> getAllAreas() async {
    if (shouldThrow != null) throw shouldThrow!;
    return mockGetAllAreasResponse ?? ListResponse(items: []);
  }

  @override
  Future<ListResponse> getCategoryList() async {
    if (shouldThrow != null) throw shouldThrow!;
    return mockGetCategoryListResponse ?? ListResponse(items: []);
  }
}

void main() {
  group('RecipeBloc Tests', () {
    late RecipeBloc bloc;
    late MockMealRepository mockRepository;

    setUp(() {
      mockRepository = MockMealRepository();
      bloc = RecipeBloc(repository: mockRepository);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is RecipeInitial', () {
      expect(bloc.state, isA<RecipeInitial>());
    });

    group('LoadRecipesEvent', () {
      test('emits RecipeLoading then RecipeLoaded when successful', () async {
        // Arrange
        final testMeal = MealModel(idMeal: '1', strMeal: 'Test Meal');
        final testCategory = CategoryModel(strCategory: 'Test Category');
        final testArea = ListItemModel(name: 'Test Area');

        mockRepository.mockSearchMealByNameResponse = MealsResponse(meals: [testMeal]);
        mockRepository.mockGetAllCategoriesResponse = CategoriesResponse(categories: [testCategory]);
        mockRepository.mockGetAllAreasResponse = ListResponse(items: [testArea]);

        // Act & Assert
        final expectedStates = [
          isA<RecipeLoading>(),
          isA<RecipeLoaded>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expectedStates));

        bloc.add(const LoadRecipesEvent());
        await Future.delayed(const Duration(milliseconds: 100));
      });

      test('emits RecipeLoading then RecipeError when repository throws', () async {
        // Arrange
        mockRepository.shouldThrow = Exception('Network error');

        // Act & Assert
        final expectedStates = [
          isA<RecipeLoading>(),
          isA<RecipeError>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expectedStates));

        bloc.add(const LoadRecipesEvent());
        await Future.delayed(const Duration(milliseconds: 100));
      });
    });

    group('SearchRecipesEvent', () {
      test('emits RecipeLoaded with search results when query is not empty', () async {
        // Arrange
        final testMeal = MealModel(idMeal: '1', strMeal: 'Chicken');
        final testCategory = CategoryModel(strCategory: 'Test');
        final testArea = ListItemModel(name: 'Test');

        mockRepository.mockSearchMealByNameResponse = MealsResponse(meals: [testMeal]);
        mockRepository.mockGetAllCategoriesResponse = CategoriesResponse(categories: [testCategory]);
        mockRepository.mockGetAllAreasResponse = ListResponse(items: [testArea]);

        // Act & Assert
        final expectedStates = [
          isA<RecipeLoading>(),
          isA<RecipeLoaded>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expectedStates));

        bloc.add(const SearchRecipesEvent('chicken'));
        await Future.delayed(const Duration(milliseconds: 100));
      });

      test('triggers LoadRecipesEvent when query is empty', () async {
        // Arrange
        final testMeal = MealModel(idMeal: '1', strMeal: 'Test');
        mockRepository.mockSearchMealByNameResponse = MealsResponse(meals: [testMeal]);
        mockRepository.mockGetAllCategoriesResponse = CategoriesResponse(categories: []);
        mockRepository.mockGetAllAreasResponse = ListResponse(items: []);

        // Act & Assert
        expectLater(bloc.stream, emitsInOrder([isA<RecipeLoading>(), isA<RecipeLoaded>()]));

        bloc.add(const SearchRecipesEvent(''));
        await Future.delayed(const Duration(milliseconds: 200));
      });
    });

    group('FilterByCategoryEvent', () {
      test('emits RecipeLoading then RecipeLoaded when successful', () async {
        // Arrange
        mockRepository.mockFilterByCategoryResponse = FilteredMealsResponse(
          meals: [FilteredMealModel(idMeal: '1', strMeal: 'Test')],
        );
        mockRepository.mockGetAllCategoriesResponse = CategoriesResponse(categories: []);
        mockRepository.mockGetAllAreasResponse = ListResponse(items: []);

        // Act & Assert
        final expectedStates = [
          isA<RecipeLoading>(),
          isA<RecipeLoaded>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expectedStates));

        bloc.add(const FilterByCategoryEvent('Chicken'));
        await Future.delayed(const Duration(milliseconds: 200));
      });
    });

    group('FilterByAreaEvent', () {
      test('emits RecipeLoading then RecipeLoaded when successful', () async {
        // Arrange
        mockRepository.mockFilterByAreaResponse = FilteredMealsResponse(
          meals: [FilteredMealModel(idMeal: '1', strMeal: 'Test')],
        );
        mockRepository.mockGetAllCategoriesResponse = CategoriesResponse(categories: []);
        mockRepository.mockGetAllAreasResponse = ListResponse(items: []);

        // Act & Assert
        final expectedStates = [
          isA<RecipeLoading>(),
          isA<RecipeLoaded>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expectedStates));

        bloc.add(const FilterByAreaEvent('Italian'));
        await Future.delayed(const Duration(milliseconds: 200));
      });
    });

    group('ClearFiltersEvent', () {
      test('triggers LoadRecipesEvent to reset filters', () async {
        // Arrange
        final testMeal = MealModel(idMeal: '1', strMeal: 'Test');
        mockRepository.mockSearchMealByNameResponse = MealsResponse(meals: [testMeal]);
        mockRepository.mockGetAllCategoriesResponse = CategoriesResponse(categories: []);
        mockRepository.mockGetAllAreasResponse = ListResponse(items: []);

        // Act - ClearFiltersEvent triggers LoadRecipesEvent
        bloc.add(const ClearFiltersEvent());
        await Future.delayed(const Duration(milliseconds: 150));

        // Assert - Should have loaded recipes
        final state = bloc.state;
        expect(state, isA<RecipeLoaded>());
      });
    });

    group('SortRecipesEvent', () {
      test('sorts meals A-Z when SortOrder.aToZ', () async {
        // Arrange - First load some meals
        final meal1 = MealModel(idMeal: '1', strMeal: 'Zebra');
        final meal2 = MealModel(idMeal: '2', strMeal: 'Apple');
        mockRepository.mockSearchMealByNameResponse = MealsResponse(meals: [meal1, meal2]);
        mockRepository.mockGetAllCategoriesResponse = CategoriesResponse(categories: []);
        mockRepository.mockGetAllAreasResponse = ListResponse(items: []);

        bloc.add(const LoadRecipesEvent());
        await Future.delayed(const Duration(milliseconds: 200));

        // Verify state is loaded
        var state = bloc.state;
        expect(state, isA<RecipeLoaded>());

        // Act
        bloc.add(const SortRecipesEvent(SortOrder.aToZ));
        await Future.delayed(const Duration(milliseconds: 150));

        // Assert
        state = bloc.state;
        expect(state, isA<RecipeLoaded>());
        if (state is RecipeLoaded && state.meals.length >= 2) {
          final sortedNames = state.meals.map((m) => m.strMeal ?? '').toList();
          expect(sortedNames.first, 'Apple');
          expect(sortedNames.last, 'Zebra');
        }
      });

      test('sorts meals Z-A when SortOrder.zToA', () async {
        // Arrange - First load some meals
        final meal1 = MealModel(idMeal: '1', strMeal: 'Apple');
        final meal2 = MealModel(idMeal: '2', strMeal: 'Zebra');
        mockRepository.mockSearchMealByNameResponse = MealsResponse(meals: [meal1, meal2]);
        mockRepository.mockGetAllCategoriesResponse = CategoriesResponse(categories: []);
        mockRepository.mockGetAllAreasResponse = ListResponse(items: []);

        bloc.add(const LoadRecipesEvent());
        await Future.delayed(const Duration(milliseconds: 200));

        // Verify state is loaded
        var state = bloc.state;
        expect(state, isA<RecipeLoaded>());

        // Act
        bloc.add(const SortRecipesEvent(SortOrder.zToA));
        await Future.delayed(const Duration(milliseconds: 150));

        // Assert
        state = bloc.state;
        expect(state, isA<RecipeLoaded>());
        if (state is RecipeLoaded && state.meals.length >= 2) {
          final sortedNames = state.meals.map((m) => m.strMeal ?? '').toList();
          expect(sortedNames.first, 'Zebra');
          expect(sortedNames.last, 'Apple');
        }
      });
    });
  });
}
