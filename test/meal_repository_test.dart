import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder_app/features/recipes/data/datasources/meal_api_service.dart';
import 'package:recipe_finder_app/features/recipes/data/models/meal_model.dart';
import 'package:recipe_finder_app/features/recipes/data/models/filtered_meal_model.dart';
import 'package:recipe_finder_app/features/recipes/data/models/category_model.dart';
import 'package:recipe_finder_app/features/recipes/data/repositories/meal_repository.dart';

// Mock API Service
class MockMealApiService extends MealApiService {
  MockMealApiService() : super();

  MealsResponse? mockSearchMealByNameResponse;
  MealsResponse? mockLookupMealByIdResponse;
  MealsResponse? mockGetRandomMealResponse;
  MealsResponse? mockSearchMealByFirstLetterResponse;
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
    if (mockSearchMealByNameResponse != null) {
      return mockSearchMealByNameResponse!;
    }
    return MealsResponse(meals: []);
  }

  @override
  Future<MealsResponse> lookupMealById(String id) async {
    if (shouldThrow != null) throw shouldThrow!;
    if (mockLookupMealByIdResponse != null) {
      return mockLookupMealByIdResponse!;
    }
    return MealsResponse(meals: []);
  }

  @override
  Future<MealsResponse> getRandomMeal() async {
    if (shouldThrow != null) throw shouldThrow!;
    if (mockGetRandomMealResponse != null) {
      return mockGetRandomMealResponse!;
    }
    return MealsResponse(meals: []);
  }

  @override
  Future<MealsResponse> searchMealByFirstLetter(String letter) async {
    if (shouldThrow != null) throw shouldThrow!;
    if (mockSearchMealByFirstLetterResponse != null) {
      return mockSearchMealByFirstLetterResponse!;
    }
    return MealsResponse(meals: []);
  }

  @override
  Future<FilteredMealsResponse> filterByCategory(String category) async {
    if (shouldThrow != null) throw shouldThrow!;
    if (mockFilterByCategoryResponse != null) {
      return mockFilterByCategoryResponse!;
    }
    return FilteredMealsResponse(meals: []);
  }

  @override
  Future<FilteredMealsResponse> filterByArea(String area) async {
    if (shouldThrow != null) throw shouldThrow!;
    if (mockFilterByAreaResponse != null) {
      return mockFilterByAreaResponse!;
    }
    return FilteredMealsResponse(meals: []);
  }

  @override
  Future<FilteredMealsResponse> filterByIngredient(String ingredient) async {
    if (shouldThrow != null) throw shouldThrow!;
    if (mockFilterByIngredientResponse != null) {
      return mockFilterByIngredientResponse!;
    }
    return FilteredMealsResponse(meals: []);
  }

  @override
  Future<CategoriesResponse> getAllCategories() async {
    if (shouldThrow != null) throw shouldThrow!;
    if (mockGetAllCategoriesResponse != null) {
      return mockGetAllCategoriesResponse!;
    }
    return CategoriesResponse(categories: []);
  }

  @override
  Future<ListResponse> getAllAreas() async {
    if (shouldThrow != null) throw shouldThrow!;
    if (mockGetAllAreasResponse != null) {
      return mockGetAllAreasResponse!;
    }
    return ListResponse(items: []);
  }

  @override
  Future<ListResponse> getCategoryList() async {
    if (shouldThrow != null) throw shouldThrow!;
    if (mockGetCategoryListResponse != null) {
      return mockGetCategoryListResponse!;
    }
    return ListResponse(items: []);
  }
}

void main() {
  group('MealRepository Tests', () {
    late MealRepositoryImpl repository;
    late MockMealApiService mockApiService;

    setUp(() {
      mockApiService = MockMealApiService();
      repository = MealRepositoryImpl(apiService: mockApiService);
    });

    group('searchMealByName', () {
      test('should return MealsResponse when API call is successful', () async {
        // Arrange
        final testMeal = MealModel(
          idMeal: '52772',
          strMeal: 'Teriyaki Chicken Casserole',
          strCategory: 'Chicken',
        );
        mockApiService.mockSearchMealByNameResponse = MealsResponse(
          meals: [testMeal],
        );

        // Act
        final result = await repository.searchMealByName('chicken');

        // Assert
        expect(result.meals.length, 1);
        expect(result.meals.first.idMeal, '52772');
        expect(result.meals.first.strMeal, 'Teriyaki Chicken Casserole');
      });

      test('should throw Exception when API call fails', () async {
        // Arrange
        mockApiService.shouldThrow = Exception('Network error');

        // Act & Assert
        expect(
          () => repository.searchMealByName('chicken'),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('lookupMealById', () {
      test('should return MealsResponse when API call is successful', () async {
        // Arrange
        final testMeal = MealModel(
          idMeal: '52772',
          strMeal: 'Teriyaki Chicken Casserole',
        );
        mockApiService.mockLookupMealByIdResponse = MealsResponse(
          meals: [testMeal],
        );

        // Act
        final result = await repository.lookupMealById('52772');

        // Assert
        expect(result.meals.length, 1);
        expect(result.meals.first.idMeal, '52772');
      });

      test('should throw Exception when API call fails', () async {
        // Arrange
        mockApiService.shouldThrow = Exception('Network error');

        // Act & Assert
        expect(
          () => repository.lookupMealById('52772'),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getRandomMeal', () {
      test('should return MealsResponse when API call is successful', () async {
        // Arrange
        final testMeal = MealModel(
          idMeal: '52772',
          strMeal: 'Random Meal',
        );
        mockApiService.mockGetRandomMealResponse = MealsResponse(
          meals: [testMeal],
        );

        // Act
        final result = await repository.getRandomMeal();

        // Assert
        expect(result.meals.length, 1);
        expect(result.meals.first.idMeal, '52772');
      });

      test('should throw Exception when API call fails', () async {
        // Arrange
        mockApiService.shouldThrow = Exception('Network error');

        // Act & Assert
        expect(
          () => repository.getRandomMeal(),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('filterByCategory', () {
      test('should return FilteredMealsResponse when API call is successful', () async {
        // Arrange
        final testMeal = FilteredMealModel(
          idMeal: '52772',
          strMeal: 'Seafood Dish',
          strMealThumb: 'https://example.com/image.jpg',
        );
        mockApiService.mockFilterByCategoryResponse = FilteredMealsResponse(
          meals: [testMeal],
        );

        // Act
        final result = await repository.filterByCategory('Seafood');

        // Assert
        expect(result.meals.length, 1);
        expect(result.meals.first.idMeal, '52772');
      });

      test('should throw Exception when API call fails', () async {
        // Arrange
        mockApiService.shouldThrow = Exception('Network error');

        // Act & Assert
        expect(
          () => repository.filterByCategory('Seafood'),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('filterByArea', () {
      test('should return FilteredMealsResponse when API call is successful', () async {
        // Arrange
        final testMeal = FilteredMealModel(
          idMeal: '52772',
          strMeal: 'Italian Dish',
          strMealThumb: 'https://example.com/image.jpg',
        );
        mockApiService.mockFilterByAreaResponse = FilteredMealsResponse(
          meals: [testMeal],
        );

        // Act
        final result = await repository.filterByArea('Italian');

        // Assert
        expect(result.meals.length, 1);
        expect(result.meals.first.idMeal, '52772');
      });

      test('should throw Exception when API call fails', () async {
        // Arrange
        mockApiService.shouldThrow = Exception('Network error');

        // Act & Assert
        expect(
          () => repository.filterByArea('Italian'),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getAllCategories', () {
      test('should return CategoriesResponse when API call is successful', () async {
        // Arrange
        final testCategory = CategoryModel(
          idCategory: '1',
          strCategory: 'Chicken',
          strCategoryThumb: 'https://example.com/thumb.jpg',
          strCategoryDescription: 'Chicken dishes',
        );
        mockApiService.mockGetAllCategoriesResponse = CategoriesResponse(
          categories: [testCategory],
        );

        // Act
        final result = await repository.getAllCategories();

        // Assert
        expect(result.categories.length, 1);
        expect(result.categories.first.strCategory, 'Chicken');
      });

      test('should throw Exception when API call fails', () async {
        // Arrange
        mockApiService.shouldThrow = Exception('Network error');

        // Act & Assert
        expect(
          () => repository.getAllCategories(),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getAllAreas', () {
      test('should return ListResponse when API call is successful', () async {
        // Arrange
        final testItem = ListItemModel.fromJson({'strArea': 'American'});
        mockApiService.mockGetAllAreasResponse = ListResponse(items: [testItem]);

        // Act
        final result = await repository.getAllAreas();

        // Assert
        expect(result.items.length, 1);
        expect(result.items.first.name, 'American');
      });

      test('should throw Exception when API call fails', () async {
        // Arrange
        mockApiService.shouldThrow = Exception('Network error');

        // Act & Assert
        expect(
          () => repository.getAllAreas(),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('searchMealByFirstLetter', () {
      test('should return MealsResponse when API call is successful', () async {
        // Arrange
        final testMeal = MealModel(
          idMeal: '52772',
          strMeal: 'Arrabiata',
        );
        mockApiService.mockSearchMealByFirstLetterResponse = MealsResponse(
          meals: [testMeal],
        );

        // Act
        final result = await repository.searchMealByFirstLetter('a');

        // Assert
        expect(result.meals.length, 1);
        expect(result.meals.first.strMeal, 'Arrabiata');
      });

      test('should throw Exception when API call fails', () async {
        // Arrange
        mockApiService.shouldThrow = Exception('Network error');

        // Act & Assert
        expect(
          () => repository.searchMealByFirstLetter('a'),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('filterByIngredient', () {
      test('should return FilteredMealsResponse when API call is successful', () async {
        // Arrange
        final testMeal = FilteredMealModel(
          idMeal: '52772',
          strMeal: 'Chicken Dish',
          strMealThumb: 'https://example.com/image.jpg',
        );
        mockApiService.mockFilterByIngredientResponse = FilteredMealsResponse(
          meals: [testMeal],
        );

        // Act
        final result = await repository.filterByIngredient('chicken');

        // Assert
        expect(result.meals.length, 1);
        expect(result.meals.first.idMeal, '52772');
      });

      test('should throw Exception when API call fails', () async {
        // Arrange
        mockApiService.shouldThrow = Exception('Network error');

        // Act & Assert
        expect(
          () => repository.filterByIngredient('chicken'),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
