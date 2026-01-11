class MealModel {
  final String? idMeal;
  final String? strMeal;
  final String? strMealAlternate;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final String? strIngredient1;
  final String? strIngredient2;
  final String? strIngredient3;
  final String? strIngredient4;
  final String? strIngredient5;
  final String? strIngredient6;
  final String? strIngredient7;
  final String? strIngredient8;
  final String? strIngredient9;
  final String? strIngredient10;
  final String? strIngredient11;
  final String? strIngredient12;
  final String? strIngredient13;
  final String? strIngredient14;
  final String? strIngredient15;
  final String? strIngredient16;
  final String? strIngredient17;
  final String? strIngredient18;
  final String? strIngredient19;
  final String? strIngredient20;
  final String? strMeasure1;
  final String? strMeasure2;
  final String? strMeasure3;
  final String? strMeasure4;
  final String? strMeasure5;
  final String? strMeasure6;
  final String? strMeasure7;
  final String? strMeasure8;
  final String? strMeasure9;
  final String? strMeasure10;
  final String? strMeasure11;
  final String? strMeasure12;
  final String? strMeasure13;
  final String? strMeasure14;
  final String? strMeasure15;
  final String? strMeasure16;
  final String? strMeasure17;
  final String? strMeasure18;
  final String? strMeasure19;
  final String? strMeasure20;
  final String? strSource;
  final String? strImageSource;
  final String? strCreativeCommonsConfirmed;
  final String? dateModified;

  MealModel({
    this.idMeal,
    this.strMeal,
    this.strMealAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strIngredient16,
    this.strIngredient17,
    this.strIngredient18,
    this.strIngredient19,
    this.strIngredient20,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
    this.strMeasure16,
    this.strMeasure17,
    this.strMeasure18,
    this.strMeasure19,
    this.strMeasure20,
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      idMeal: json['idMeal'] as String?,
      strMeal: json['strMeal'] as String?,
      strMealAlternate: json['strMealAlternate'] as String?,
      strCategory: json['strCategory'] as String?,
      strArea: json['strArea'] as String?,
      strInstructions: json['strInstructions'] as String?,
      strMealThumb: json['strMealThumb'] as String?,
      strTags: json['strTags'] as String?,
      strYoutube: json['strYoutube'] as String?,
      strIngredient1: json['strIngredient1'] as String?,
      strIngredient2: json['strIngredient2'] as String?,
      strIngredient3: json['strIngredient3'] as String?,
      strIngredient4: json['strIngredient4'] as String?,
      strIngredient5: json['strIngredient5'] as String?,
      strIngredient6: json['strIngredient6'] as String?,
      strIngredient7: json['strIngredient7'] as String?,
      strIngredient8: json['strIngredient8'] as String?,
      strIngredient9: json['strIngredient9'] as String?,
      strIngredient10: json['strIngredient10'] as String?,
      strIngredient11: json['strIngredient11'] as String?,
      strIngredient12: json['strIngredient12'] as String?,
      strIngredient13: json['strIngredient13'] as String?,
      strIngredient14: json['strIngredient14'] as String?,
      strIngredient15: json['strIngredient15'] as String?,
      strIngredient16: json['strIngredient16'] as String?,
      strIngredient17: json['strIngredient17'] as String?,
      strIngredient18: json['strIngredient18'] as String?,
      strIngredient19: json['strIngredient19'] as String?,
      strIngredient20: json['strIngredient20'] as String?,
      strMeasure1: json['strMeasure1'] as String?,
      strMeasure2: json['strMeasure2'] as String?,
      strMeasure3: json['strMeasure3'] as String?,
      strMeasure4: json['strMeasure4'] as String?,
      strMeasure5: json['strMeasure5'] as String?,
      strMeasure6: json['strMeasure6'] as String?,
      strMeasure7: json['strMeasure7'] as String?,
      strMeasure8: json['strMeasure8'] as String?,
      strMeasure9: json['strMeasure9'] as String?,
      strMeasure10: json['strMeasure10'] as String?,
      strMeasure11: json['strMeasure11'] as String?,
      strMeasure12: json['strMeasure12'] as String?,
      strMeasure13: json['strMeasure13'] as String?,
      strMeasure14: json['strMeasure14'] as String?,
      strMeasure15: json['strMeasure15'] as String?,
      strMeasure16: json['strMeasure16'] as String?,
      strMeasure17: json['strMeasure17'] as String?,
      strMeasure18: json['strMeasure18'] as String?,
      strMeasure19: json['strMeasure19'] as String?,
      strMeasure20: json['strMeasure20'] as String?,
      strSource: json['strSource'] as String?,
      strImageSource: json['strImageSource'] as String?,
      strCreativeCommonsConfirmed: json['strCreativeCommonsConfirmed'] as String?,
      dateModified: json['dateModified'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealAlternate': strMealAlternate,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strMealThumb': strMealThumb,
      'strTags': strTags,
      'strYoutube': strYoutube,
      'strIngredient1': strIngredient1,
      'strIngredient2': strIngredient2,
      'strIngredient3': strIngredient3,
      'strIngredient4': strIngredient4,
      'strIngredient5': strIngredient5,
      'strIngredient6': strIngredient6,
      'strIngredient7': strIngredient7,
      'strIngredient8': strIngredient8,
      'strIngredient9': strIngredient9,
      'strIngredient10': strIngredient10,
      'strIngredient11': strIngredient11,
      'strIngredient12': strIngredient12,
      'strIngredient13': strIngredient13,
      'strIngredient14': strIngredient14,
      'strIngredient15': strIngredient15,
      'strIngredient16': strIngredient16,
      'strIngredient17': strIngredient17,
      'strIngredient18': strIngredient18,
      'strIngredient19': strIngredient19,
      'strIngredient20': strIngredient20,
      'strMeasure1': strMeasure1,
      'strMeasure2': strMeasure2,
      'strMeasure3': strMeasure3,
      'strMeasure4': strMeasure4,
      'strMeasure5': strMeasure5,
      'strMeasure6': strMeasure6,
      'strMeasure7': strMeasure7,
      'strMeasure8': strMeasure8,
      'strMeasure9': strMeasure9,
      'strMeasure10': strMeasure10,
      'strMeasure11': strMeasure11,
      'strMeasure12': strMeasure12,
      'strMeasure13': strMeasure13,
      'strMeasure14': strMeasure14,
      'strMeasure15': strMeasure15,
      'strMeasure16': strMeasure16,
      'strMeasure17': strMeasure17,
      'strMeasure18': strMeasure18,
      'strMeasure19': strMeasure19,
      'strMeasure20': strMeasure20,
      'strSource': strSource,
      'strImageSource': strImageSource,
      'strCreativeCommonsConfirmed': strCreativeCommonsConfirmed,
      'dateModified': dateModified,
    };
  }

  // Helper method to get all ingredients as a list (excluding empty ones)
  List<String> getIngredients() {
    final ingredients = [
      strIngredient1,
      strIngredient2,
      strIngredient3,
      strIngredient4,
      strIngredient5,
      strIngredient6,
      strIngredient7,
      strIngredient8,
      strIngredient9,
      strIngredient10,
      strIngredient11,
      strIngredient12,
      strIngredient13,
      strIngredient14,
      strIngredient15,
      strIngredient16,
      strIngredient17,
      strIngredient18,
      strIngredient19,
      strIngredient20,
    ];
    return ingredients
        .where((ingredient) => ingredient != null && ingredient.trim().isNotEmpty)
        .map((ingredient) => ingredient!.trim())
        .toList();
  }

  // Helper method to get all measures as a list (excluding empty ones)
  List<String> getMeasures() {
    final measures = [
      strMeasure1,
      strMeasure2,
      strMeasure3,
      strMeasure4,
      strMeasure5,
      strMeasure6,
      strMeasure7,
      strMeasure8,
      strMeasure9,
      strMeasure10,
      strMeasure11,
      strMeasure12,
      strMeasure13,
      strMeasure14,
      strMeasure15,
      strMeasure16,
      strMeasure17,
      strMeasure18,
      strMeasure19,
      strMeasure20,
    ];
    return measures
        .where((measure) => measure != null && measure.trim().isNotEmpty)
        .map((measure) => measure!.trim())
        .toList();
  }

  // Helper method to get ingredients with their measures as a map
  Map<String, String> getIngredientsWithMeasures() {
    final ingredients = getIngredients();
    final measures = getMeasures();
    final Map<String, String> result = {};
    
    for (int i = 0; i < ingredients.length; i++) {
      if (i < measures.length) {
        result[ingredients[i]] = measures[i];
      } else {
        result[ingredients[i]] = '';
      }
    }
    return result;
  }

  // Helper method to get instructions as a list of steps
  List<String> getInstructionsSteps() {
    if (strInstructions == null || strInstructions!.trim().isEmpty) {
      return [];
    }

    // Split by common step indicators
    final instructions = strInstructions!
        .split(RegExp(r'\r?\n(?=\s*step\s+\d+)|(?=\d+\.)|(?=\d+\))', caseSensitive: false))
        .where((step) => step.trim().isNotEmpty)
        .map((step) => step.trim())
        .toList();

    // If no steps found, return the whole instruction as a single step
    if (instructions.isEmpty) {
      return [strInstructions!.trim()];
    }

    return instructions;
  }

  // Helper method to extract YouTube video ID from URL
  String? getYouTubeVideoId() {
    if (strYoutube == null || strYoutube!.trim().isEmpty) {
      return null;
    }

    final url = strYoutube!.trim();
    
    // Extract video ID from various YouTube URL formats
    final patterns = [
      RegExp(r'(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([a-zA-Z0-9_-]{11})'),
      RegExp(r'youtube\.com\/watch\?.*v=([a-zA-Z0-9_-]{11})'),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }
    }

    return null;
  }

  // Helper method to get YouTube embed URL
  String? getYouTubeEmbedUrl() {
    final videoId = getYouTubeVideoId();
    if (videoId == null) return null;
    return 'https://www.youtube.com/embed/$videoId';
  }

  // Helper method to check if meal has all required details for detail page
  bool hasFullDetails() {
    return strInstructions != null && 
           strInstructions!.isNotEmpty && 
           getIngredients().isNotEmpty;
  }

  // Helper method to get tags as a list
  List<String> getTagsList() {
    if (strTags == null || strTags!.trim().isEmpty) {
      return [];
    }
    return strTags!
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();
  }
}

// Response model for the API response wrapper
class MealsResponse {
  final List<MealModel> meals;

  MealsResponse({required this.meals});

  factory MealsResponse.fromJson(Map<String, dynamic> json) {
    final mealsList = json['meals'] as List<dynamic>?;
    return MealsResponse(
      meals: mealsList != null
          ? mealsList.map((meal) => MealModel.fromJson(meal as Map<String, dynamic>)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meals': meals.map((meal) => meal.toJson()).toList(),
    };
  }
}
