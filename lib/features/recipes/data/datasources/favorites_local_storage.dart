import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal_model.dart';

class FavoritesLocalStorage {
  static const String _favoritesKey = 'favorites';

  // Get all favorites
  Future<List<MealModel>> getFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString(_favoritesKey);
      
      if (favoritesJson == null) {
        return [];
      }

      final List<dynamic> favoritesList = json.decode(favoritesJson);
      return favoritesList
          .map((json) => MealModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Save a favorite
  Future<bool> saveFavorite(MealModel meal) async {
    try {
      final favorites = await getFavorites();
      
      // Check if already exists
      if (favorites.any((fav) => fav.idMeal == meal.idMeal)) {
        return true; // Already exists
      }

      favorites.add(meal);
      return await _saveFavorites(favorites);
    } catch (e) {
      return false;
    }
  }

  // Remove a favorite
  Future<bool> removeFavorite(String mealId) async {
    try {
      final favorites = await getFavorites();
      favorites.removeWhere((fav) => fav.idMeal == mealId);
      return await _saveFavorites(favorites);
    } catch (e) {
      return false;
    }
  }

  // Check if a meal is favorite
  Future<bool> isFavorite(String mealId) async {
    try {
      final favorites = await getFavorites();
      return favorites.any((fav) => fav.idMeal == mealId);
    } catch (e) {
      return false;
    }
  }

  // Save favorites list
  Future<bool> _saveFavorites(List<MealModel> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = json.encode(
        favorites.map((meal) => meal.toJson()).toList(),
      );
      return await prefs.setString(_favoritesKey, favoritesJson);
    } catch (e) {
      return false;
    }
  }
}
