import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder_app/features/recipes/data/models/meal_model.dart';
import 'package:recipe_finder_app/features/recipes/data/models/category_model.dart';
import 'package:recipe_finder_app/features/recipes/data/models/filtered_meal_model.dart';
import 'package:recipe_finder_app/features/recipes/data/datasources/meal_api_service.dart';

void main() {
  group('MealModel Tests', () {
    test('MealModel parses JSON correctly', () {
      final json = {
        'idMeal': '53262',
        'strMeal': 'Adana kebab',
        'strMealAlternate': null,
        'strCategory': 'Lamb',
        'strArea': 'Turkish',
        'strInstructions': 'step 1\nFinely chop the peppers...',
        'strMealThumb': 'https://www.themealdb.com/images/media/meals/04axct1763793018.jpg',
        'strTags': null,
        'strYoutube': 'https://www.youtube.com/watch?v=Wj7sXu9B_ME',
        'strIngredient1': 'Romano Pepper',
        'strIngredient2': 'Lamb Mince',
        'strIngredient3': 'Red Pepper Paste',
        'strIngredient4': 'Pul Biber',
        'strIngredient5': 'Sunflower Oil',
        'strIngredient6': '',
        'strMeasure1': '2 large',
        'strMeasure2': '800g',
        'strMeasure3': '3  tablespoons',
        'strMeasure4': '1 tablespoon',
        'strMeasure5': '3  tablespoons',
        'strMeasure6': ' ',
      };

      final meal = MealModel.fromJson(json);

      expect(meal.idMeal, '53262');
      expect(meal.strMeal, 'Adana kebab');
      expect(meal.strCategory, 'Lamb');
      expect(meal.strArea, 'Turkish');
      expect(meal.getIngredients().length, 5);
      expect(meal.getMeasures().length, 5);
    });

    test('MealsResponse parses JSON correctly', () {
      final json = {
        'meals': [
          {
            'idMeal': '53262',
            'strMeal': 'Adana kebab',
            'strCategory': 'Lamb',
            'strArea': 'Turkish',
          }
        ]
      };

      final response = MealsResponse.fromJson(json);

      expect(response.meals.length, 1);
      expect(response.meals.first.idMeal, '53262');
      expect(response.meals.first.strMeal, 'Adana kebab');
    });

    test('getIngredients() filters empty ingredients', () {
      final meal = MealModel(
        strIngredient1: 'Ingredient 1',
        strIngredient2: 'Ingredient 2',
        strIngredient3: '',
        strIngredient4: '   ',
        strIngredient5: 'Ingredient 5',
      );

      final ingredients = meal.getIngredients();

      expect(ingredients.length, 3);
      expect(ingredients, ['Ingredient 1', 'Ingredient 2', 'Ingredient 5']);
    });

    test('getIngredientsWithMeasures() returns correct map', () {
      final meal = MealModel(
        strIngredient1: 'Ingredient 1',
        strIngredient2: 'Ingredient 2',
        strMeasure1: '1 cup',
        strMeasure2: '2 tbsp',
      );

      final map = meal.getIngredientsWithMeasures();

      expect(map.length, 2);
      expect(map['Ingredient 1'], '1 cup');
      expect(map['Ingredient 2'], '2 tbsp');
    });

    test('getInstructionsSteps() parses instructions correctly', () {
      final meal = MealModel(
        strInstructions: 'step 1\nDo this first\nstep 2\nDo this second',
      );

      final steps = meal.getInstructionsSteps();

      expect(steps.isNotEmpty, true);
    });

    test('getYouTubeVideoId() extracts video ID from URL', () {
      final meal = MealModel(
        strYoutube: 'https://www.youtube.com/watch?v=Wj7sXu9B_ME',
      );

      final videoId = meal.getYouTubeVideoId();

      expect(videoId, 'Wj7sXu9B_ME');
    });

    test('getYouTubeEmbedUrl() returns embed URL', () {
      final meal = MealModel(
        strYoutube: 'https://www.youtube.com/watch?v=Wj7sXu9B_ME',
      );

      final embedUrl = meal.getYouTubeEmbedUrl();

      expect(embedUrl, 'https://www.youtube.com/embed/Wj7sXu9B_ME');
    });

    test('getTagsList() parses tags correctly', () {
      final meal = MealModel(
        strTags: 'tag1, tag2, tag3',
      );

      final tags = meal.getTagsList();

      expect(tags.length, 3);
      expect(tags, ['tag1', 'tag2', 'tag3']);
    });

    test('hasFullDetails() returns true when meal has complete data', () {
      final meal = MealModel(
        strInstructions: 'Some instructions',
        strIngredient1: 'Ingredient 1',
      );

      expect(meal.hasFullDetails(), true);
    });

    test('hasFullDetails() returns false when meal lacks data', () {
      final meal = MealModel(
        strInstructions: null,
      );

      expect(meal.hasFullDetails(), false);
    });
  });

  group('CategoryModel Tests', () {
    test('CategoryModel parses JSON correctly', () {
      final json = {
        'idCategory': '1',
        'strCategory': 'Beef',
        'strCategoryThumb': 'https://example.com/thumb.jpg',
        'strCategoryDescription': 'Beef description',
      };

      final category = CategoryModel.fromJson(json);

      expect(category.idCategory, '1');
      expect(category.strCategory, 'Beef');
      expect(category.strCategoryThumb, isNotNull);
    });

    test('CategoriesResponse parses JSON correctly', () {
      final json = {
        'categories': [
          {
            'idCategory': '1',
            'strCategory': 'Beef',
            'strCategoryThumb': 'https://example.com/thumb.jpg',
            'strCategoryDescription': 'Beef description',
          }
        ]
      };

      final response = CategoriesResponse.fromJson(json);

      expect(response.categories.length, 1);
      expect(response.categories.first.strCategory, 'Beef');
    });
  });

  group('FilteredMealModel Tests', () {
    test('FilteredMealModel parses JSON correctly', () {
      final json = {
        'idMeal': '52772',
        'strMeal': 'Teriyaki Chicken Casserole',
        'strMealThumb': 'https://example.com/thumb.jpg',
      };

      final meal = FilteredMealModel.fromJson(json);

      expect(meal.idMeal, '52772');
      expect(meal.strMeal, 'Teriyaki Chicken Casserole');
      expect(meal.strMealThumb, isNotNull);
    });

    test('FilteredMealsResponse parses JSON correctly', () {
      final json = {
        'meals': [
          {
            'idMeal': '52772',
            'strMeal': 'Teriyaki Chicken Casserole',
            'strMealThumb': 'https://example.com/thumb.jpg',
          }
        ]
      };

      final response = FilteredMealsResponse.fromJson(json);

      expect(response.meals.length, 1);
      expect(response.meals.first.idMeal, '52772');
    });
  });

  group('ListItemModel Tests', () {
    test('ListItemModel parses category list correctly', () {
      final json = {'strCategory': 'Beef'};

      final item = ListItemModel.fromJson(json);

      expect(item.name, 'Beef');
    });

    test('ListItemModel parses area list correctly', () {
      final json = {'strArea': 'American'};

      final item = ListItemModel.fromJson(json);

      expect(item.name, 'American');
    });

    test('ListItemModel parses ingredient list correctly', () {
      final json = {'strIngredient': 'Chicken'};

      final item = ListItemModel.fromJson(json);

      expect(item.name, 'Chicken');
    });
  });

  group('API Integration Tests', () {
    final apiService = MealApiService();

    test('Search meal by name - Arrabiata', () async {
      final response = await apiService.searchMealByName('Arrabiata');
      
      expect(response.meals.isNotEmpty, true);
      expect(response.meals.first.strMeal, contains('Arrabiata'));
      expect(response.meals.first.idMeal, isNotNull);
      expect(response.meals.first.strMealThumb, isNotNull);
    });

    test('Lookup meal by id', () async {
      final response = await apiService.lookupMealById('52772');
      
      expect(response.meals.isNotEmpty, true);
      expect(response.meals.first.idMeal, '52772');
      expect(response.meals.first.strInstructions, isNotNull);
      expect(response.meals.first.getIngredients().isNotEmpty, true);
    });

    test('Get random meal', () async {
      final response = await apiService.getRandomMeal();
      
      expect(response.meals.length, 1);
      expect(response.meals.first.idMeal, isNotNull);
      expect(response.meals.first.strMeal, isNotNull);
    });

    test('Filter by category - Seafood', () async {
      final response = await apiService.filterByCategory('Seafood');
      
      expect(response.meals.isNotEmpty, true);
      expect(response.meals.first.idMeal, isNotNull);
      expect(response.meals.first.strMeal, isNotNull);
      expect(response.meals.first.strMealThumb, isNotNull);
    });

    test('Filter by area - Canadian', () async {
      final response = await apiService.filterByArea('Canadian');
      
      expect(response.meals.isNotEmpty, true);
      expect(response.meals.first.idMeal, isNotNull);
      expect(response.meals.first.strMeal, isNotNull);
    });

    test('Filter by ingredient - chicken_breast', () async {
      final response = await apiService.filterByIngredient('chicken_breast');
      
      expect(response.meals.isNotEmpty, true);
      expect(response.meals.first.idMeal, isNotNull);
      expect(response.meals.first.strMeal, isNotNull);
    });

    test('Get all categories', () async {
      final response = await apiService.getAllCategories();
      
      expect(response.categories.isNotEmpty, true);
      expect(response.categories.first.strCategory, isNotNull);
      expect(response.categories.first.idCategory, isNotNull);
    });

    test('Get all areas list', () async {
      final response = await apiService.getAllAreas();
      
      expect(response.items.isNotEmpty, true);
      expect(response.items.first.name, isNotNull);
    });

    test('Get category list', () async {
      final response = await apiService.getCategoryList();
      
      expect(response.items.isNotEmpty, true);
      expect(response.items.first.name, isNotNull);
    });

    test('Get ingredient list', () async {
      final response = await apiService.getIngredientList();
      
      expect(response.items.isNotEmpty, true);
      expect(response.items.first.name, isNotNull);
    });
  });
}
