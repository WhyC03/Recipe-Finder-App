# Recipe Finder App 🍳

A Flutter-based mobile application that helps users discover and explore delicious recipes from around the world using TheMealDB API.

## 📱 Features

### Recipe Discovery
- **Browse Recipes**: Explore a vast collection of recipes from TheMealDB API
- **Search Functionality**: Search recipes by name with 500ms debounce for optimal performance
- **Filter Options**: 
  - Filter by category (e.g., Seafood, Dessert, Vegetarian)
  - Filter by cuisine area (e.g., Italian, Indian, Mexican)
  - Clear all filters with a single tap
- **Sort Options**: Sort recipes alphabetically (A-Z or Z-A)
- **Active Filter Indicator**: Visual badge showing the number of active filters

### Recipe Details
- **Comprehensive Information**: View recipe name, image, category, and cuisine area
- **Ingredients List**: Detailed list of ingredients with measurements
- **Step-by-Step Instructions**: Numbered cooking instructions for easy following
- **YouTube Integration**: Watch recipe tutorials via external YouTube links
- **Favorite Toggle**: Save your favorite recipes for quick access

### Favorites Management
- **Favorites Page**: Dedicated page to view all saved recipes
- **Persistent Storage**: Favorites are saved locally using SharedPreferences
- **Remove from Favorites**: Easily remove recipes from your favorites list

### User Experience
- **Modern UI**: Clean and intuitive interface with Google Fonts (Poppins)
- **Loading States**: Visual feedback during data loading
- **Error Handling**: User-friendly error messages
- **Bottom Navigation**: Easy navigation between Home, Search, and Favorites

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **BLoC** (Business Logic Component) pattern for state management:

```
lib/
├── core/
│   ├── constants/
│   ├── di/
│   └── utils/
└── features/
    ├── recipes/
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   └── repositories/
    │   └── presentation/
    │       ├── bloc/
    │       ├── screens/
    │       └── widgets/
    └── splash/
        └── presentation/
```

### Key Patterns
- **BLoC Pattern**: State management using `flutter_bloc`
- **Repository Pattern**: Abstraction layer for data sources
- **Dependency Injection**: Using `get_it` for service location
- **Model Classes**: Complete JSON serialization/deserialization

## 🛠️ Tech Stack

- **Framework**: Flutter (SDK ^3.10.4)
- **State Management**: flutter_bloc ^9.1.1
- **API Integration**: http ^1.2.0
- **Dependency Injection**: get_it ^7.6.4
- **Local Storage**: shared_preferences ^2.2.2
- **URL Launcher**: url_launcher ^6.2.2
- **Fonts**: google_fonts ^7.0.0
- **Code Quality**: flutter_lints ^6.0.0

## 📋 Prerequisites

- Flutter SDK (3.10.4 or higher)
- Dart SDK (3.10.4 or higher)
- Android Studio / VS Code with Flutter extensions
- Android SDK (for Android development)
- Xcode (for iOS development - macOS only)

## 🚀 Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd recipe_finder_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 🧪 Testing

The project includes comprehensive test coverage:

### Test Statistics
- **Total Tests**: 76 tests (all passing)
- **Unit Tests**: 63 tests
  - Repository tests: 18 tests
  - BLoC tests: 18 tests (RecipeBloc & FavoritesBloc)
  - Model/API tests: 27 tests
- **Widget Tests**: 13 tests
  - RecipeCard: 7 tests
  - SearchBar: 3 tests
  - FavoriteButton: 3 tests

### Running Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# View coverage report (requires lcov)
genhtml coverage/lcov.info -o coverage/html
```

### Test Coverage
- **Business Logic Coverage**: 63.01% (436/692 lines)
- **Key Coverage Areas**:
  - Repository: 90.3%
  - FavoritesBloc: 76.9%
  - MealModel: 70.4%
  - RecipeBloc: 65.2%

## 📡 API Integration

This app uses [TheMealDB API](https://www.themealdb.com/api.php) - a free, open API for recipe data.

### API Endpoints Used
- Search meals by name
- Lookup meal by ID
- Get random meal
- Filter by category
- Filter by area/cuisine
- Filter by ingredient
- Get all categories
- Get all areas/cuisines
- Get ingredient list

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_strings.dart
│   ├── di/
│   │   └── injection_container.dart
│   └── utils/
│       └── sort_order.dart
│
├── features/
│   ├── recipes/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── meal_api_service.dart
│   │   │   │   └── favorites_local_storage.dart
│   │   │   ├── models/
│   │   │   │   ├── meal_model.dart
│   │   │   │   ├── category_model.dart
│   │   │   │   └── filtered_meal_model.dart
│   │   │   └── repositories/
│   │   │       └── meal_repository.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── recipe_bloc.dart
│   │       │   ├── recipe_event.dart
│   │       │   ├── recipe_state.dart
│   │       │   ├── favorites_bloc.dart
│   │       │   ├── favorites_event.dart
│   │       │   └── favorites_state.dart
│   │       ├── screens/
│   │       │   └── home_screen.dart
│   │       └── widgets/
│   │           ├── recipe_list_screen.dart
│   │           ├── search_screen.dart
│   │           ├── recipe_detail_screen.dart
│   │           ├── recipe_card.dart
│   │           ├── favorites_screen.dart
│   │           └── filter_bottom_sheet.dart
│   └── splash/
│       └── presentation/
│           └── splash_screen.dart
│
└── main.dart
```

## 🎨 Design

- **Design System**: Material Design 3
- **Font Family**: Poppins (via Google Fonts)
- **Color Scheme**: Clean white background with Material Design colors
- **Icons**: Material Icons

## 🔒 Permissions

### Android
- `INTERNET`: Required for API calls to TheMealDB
- URL queries configured for `url_launcher` package (Android 11+)

## 📝 Code Quality

- **Null Safety**: Full null safety implementation
- **SOLID Principles**: Clean architecture following SOLID principles
- **No Hardcoded Strings**: All strings defined in `AppStrings` constants
- **Linting**: Flutter recommended lints enabled
- **Error Handling**: Comprehensive error handling throughout the app

## 🚧 Known Limitations / Future Enhancements

- Grid/List view toggle (currently only List view)
- Loading skeletons/shimmer effects
- Hero animations for navigation
- Tab-based recipe detail page (Overview, Ingredients, Instructions)
- Offline caching for recipes and images
- Interactive image viewer with zoom functionality
- Embedded YouTube video player (currently links open externally)
- Favorite toggle animations

## 👨‍💻 Author

Developed as part of an internship assignment showcasing Flutter development skills, clean architecture, and modern mobile app development practices.

## 🙏 Acknowledgments

- [TheMealDB](https://www.themealdb.com/) for providing the free recipe API
- Flutter team for the amazing framework
- BLoC library contributors for excellent state management solution

---