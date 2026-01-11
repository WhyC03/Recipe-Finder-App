import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../models/meal_model.dart';
import '../models/filtered_meal_model.dart';
import '../models/category_model.dart';

class MealApiService {
  final http.Client client;

  MealApiService({http.Client? client}) : client = client ?? http.Client();

  // Search meal by name
  Future<MealsResponse> searchMealByName(String query) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.searchByName}?${ApiConstants.querySearch}=$query',
      );
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return MealsResponse.fromJson(jsonData);
      } else {
        throw Exception('${ApiErrorMessages.failedToLoadMeals}: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('${ApiErrorMessages.networkError}: $e');
    }
  }

  // List all meals by first letter
  Future<MealsResponse> searchMealByFirstLetter(String letter) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.searchByFirstLetter}?${ApiConstants.queryFirstLetter}=$letter',
      );
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return MealsResponse.fromJson(jsonData);
      } else {
        throw Exception('${ApiErrorMessages.failedToLoadMeals}: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('${ApiErrorMessages.networkError}: $e');
    }
  }

  // Lookup full meal details by id
  Future<MealsResponse> lookupMealById(String id) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.lookupById}?${ApiConstants.queryId}=$id',
      );
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return MealsResponse.fromJson(jsonData);
      } else {
        throw Exception('${ApiErrorMessages.failedToLoadMeal}: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('${ApiErrorMessages.networkError}: $e');
    }
  }

  // Lookup a single random meal
  Future<MealsResponse> getRandomMeal() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.randomMeal}');
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return MealsResponse.fromJson(jsonData);
      } else {
        throw Exception('${ApiErrorMessages.failedToLoadRandomMeal}: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('${ApiErrorMessages.networkError}: $e');
    }
  }

  // Filter by main ingredient
  Future<FilteredMealsResponse> filterByIngredient(String ingredient) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.filterByIngredient}?${ApiConstants.queryId}=$ingredient',
      );
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return FilteredMealsResponse.fromJson(jsonData);
      } else {
        throw Exception('${ApiErrorMessages.failedToFilterMeals}: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('${ApiErrorMessages.networkError}: $e');
    }
  }

  // Filter by Category
  Future<FilteredMealsResponse> filterByCategory(String category) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.filterByCategory}?${ApiConstants.queryCategory}=$category',
      );
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return FilteredMealsResponse.fromJson(jsonData);
      } else {
        throw Exception('${ApiErrorMessages.failedToFilterMeals}: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('${ApiErrorMessages.networkError}: $e');
    }
  }

  // Filter by Area
  Future<FilteredMealsResponse> filterByArea(String area) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.filterByArea}?${ApiConstants.queryArea}=$area',
      );
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return FilteredMealsResponse.fromJson(jsonData);
      } else {
        throw Exception('${ApiErrorMessages.failedToFilterMeals}: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('${ApiErrorMessages.networkError}: $e');
    }
  }

  // List all categories
  Future<CategoriesResponse> getAllCategories() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.categories}');
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return CategoriesResponse.fromJson(jsonData);
      } else {
        throw Exception('${ApiErrorMessages.failedToLoadCategories}: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('${ApiErrorMessages.networkError}: $e');
    }
  }

  // List all areas
  Future<ListResponse> getAllAreas() async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.listAreas}?${ApiConstants.queryArea}=${ApiConstants.queryListType}',
      );
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return ListResponse.fromJson(jsonData);
      } else {
        throw Exception('${ApiErrorMessages.failedToLoadAreas}: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('${ApiErrorMessages.networkError}: $e');
    }
  }

  // List all categories (simple list)
  Future<ListResponse> getCategoryList() async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.listCategories}?${ApiConstants.queryCategory}=${ApiConstants.queryListType}',
      );
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return ListResponse.fromJson(jsonData);
      } else {
        throw Exception('${ApiErrorMessages.failedToLoadCategoryList}: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('${ApiErrorMessages.networkError}: $e');
    }
  }

  // List all ingredients
  Future<ListResponse> getIngredientList() async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.listIngredients}?${ApiConstants.queryId}=${ApiConstants.queryListType}',
      );
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return ListResponse.fromJson(jsonData);
      } else {
        throw Exception('${ApiErrorMessages.failedToLoadIngredientList}: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('${ApiErrorMessages.networkError}: $e');
    }
  }
}
