// Model for filtered meal responses (used by filter.php endpoints)
// These responses only contain idMeal, strMeal, and strMealThumb
class FilteredMealModel {
  final String? idMeal;
  final String? strMeal;
  final String? strMealThumb;

  FilteredMealModel({
    this.idMeal,
    this.strMeal,
    this.strMealThumb,
  });

  factory FilteredMealModel.fromJson(Map<String, dynamic> json) {
    return FilteredMealModel(
      idMeal: json['idMeal'] as String?,
      strMeal: json['strMeal'] as String?,
      strMealThumb: json['strMealThumb'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealThumb': strMealThumb,
    };
  }
}

// Response model for filtered meal API responses
class FilteredMealsResponse {
  final List<FilteredMealModel> meals;

  FilteredMealsResponse({required this.meals});

  factory FilteredMealsResponse.fromJson(Map<String, dynamic> json) {
    final mealsList = json['meals'] as List<dynamic>?;
    return FilteredMealsResponse(
      meals: mealsList != null
          ? mealsList
              .map((meal) => FilteredMealModel.fromJson(meal as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meals': meals.map((meal) => meal.toJson()).toList(),
    };
  }
}
