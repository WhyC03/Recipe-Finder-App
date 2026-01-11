class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // API Endpoints
  static const String searchByName = '/search.php';
  static const String searchByFirstLetter = '/search.php';
  static const String lookupById = '/lookup.php';
  static const String randomMeal = '/random.php';
  static const String filterByIngredient = '/filter.php';
  static const String filterByCategory = '/filter.php';
  static const String filterByArea = '/filter.php';
  static const String categories = '/categories.php';
  static const String listCategories = '/list.php';
  static const String listAreas = '/list.php';
  static const String listIngredients = '/list.php';

  // Query Parameters
  static const String querySearch = 's';
  static const String queryFirstLetter = 'f';
  static const String queryId = 'i';
  static const String queryCategory = 'c';
  static const String queryArea = 'a';
  static const String queryListType = 'list';
}

class ApiErrorMessages {
  static const String failedToLoadMeals = 'Failed to load meals';
  static const String failedToLoadMeal = 'Failed to load meal';
  static const String failedToLoadRandomMeal = 'Failed to load random meal';
  static const String failedToFilterMeals = 'Failed to filter meals';
  static const String failedToLoadCategories = 'Failed to load categories';
  static const String failedToLoadAreas = 'Failed to load areas';
  static const String failedToLoadCategoryList = 'Failed to load category list';
  static const String failedToLoadIngredientList = 'Failed to load ingredient list';
  static const String networkError = 'Network error occurred';
  static const String invalidResponse = 'Invalid response from server';
}
