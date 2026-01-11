import '../datasources/meal_api_service.dart';
import '../models/meal_model.dart';
import '../models/filtered_meal_model.dart';
import '../models/category_model.dart';

abstract class MealRepository {
  Future<MealsResponse> searchMealByName(String query);
  Future<MealsResponse> searchMealByFirstLetter(String letter);
  Future<MealsResponse> lookupMealById(String id);
  Future<MealsResponse> getRandomMeal();
  Future<FilteredMealsResponse> filterByCategory(String category);
  Future<FilteredMealsResponse> filterByArea(String area);
  Future<FilteredMealsResponse> filterByIngredient(String ingredient);
  Future<CategoriesResponse> getAllCategories();
  Future<ListResponse> getAllAreas();
  Future<ListResponse> getCategoryList();
}

class MealRepositoryImpl implements MealRepository {
  final MealApiService apiService;

  MealRepositoryImpl({required this.apiService});

  @override
  Future<MealsResponse> searchMealByName(String query) async {
    try {
      return await apiService.searchMealByName(query);
    } catch (e) {
      throw Exception('Failed to search meals: $e');
    }
  }

  @override
  Future<MealsResponse> searchMealByFirstLetter(String letter) async {
    try {
      return await apiService.searchMealByFirstLetter(letter);
    } catch (e) {
      throw Exception('Failed to search meals by first letter: $e');
    }
  }

  @override
  Future<MealsResponse> lookupMealById(String id) async {
    try {
      return await apiService.lookupMealById(id);
    } catch (e) {
      throw Exception('Failed to lookup meal: $e');
    }
  }

  @override
  Future<MealsResponse> getRandomMeal() async {
    try {
      return await apiService.getRandomMeal();
    } catch (e) {
      throw Exception('Failed to get random meal: $e');
    }
  }

  @override
  Future<FilteredMealsResponse> filterByCategory(String category) async {
    try {
      return await apiService.filterByCategory(category);
    } catch (e) {
      throw Exception('Failed to filter by category: $e');
    }
  }

  @override
  Future<FilteredMealsResponse> filterByArea(String area) async {
    try {
      return await apiService.filterByArea(area);
    } catch (e) {
      throw Exception('Failed to filter by area: $e');
    }
  }

  @override
  Future<FilteredMealsResponse> filterByIngredient(String ingredient) async {
    try {
      return await apiService.filterByIngredient(ingredient);
    } catch (e) {
      throw Exception('Failed to filter by ingredient: $e');
    }
  }

  @override
  Future<CategoriesResponse> getAllCategories() async {
    try {
      return await apiService.getAllCategories();
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  @override
  Future<ListResponse> getAllAreas() async {
    try {
      return await apiService.getAllAreas();
    } catch (e) {
      throw Exception('Failed to get areas: $e');
    }
  }

  @override
  Future<ListResponse> getCategoryList() async {
    try {
      return await apiService.getCategoryList();
    } catch (e) {
      throw Exception('Failed to get category list: $e');
    }
  }
}
