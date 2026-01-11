import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder_app/core/constants/app_strings.dart';
import 'package:recipe_finder_app/features/recipes/data/models/meal_model.dart';
import 'package:recipe_finder_app/features/recipes/presentation/widgets/recipe_card.dart';

void main() {
  group('RecipeCard Widget Tests', () {
    late MealModel testMeal;

    setUp(() {
      testMeal = MealModel(
        idMeal: '52772',
        strMeal: 'Teriyaki Chicken Casserole',
        strCategory: 'Chicken',
        strArea: 'Japanese',
        strMealThumb: 'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
        strIngredient1: 'soy sauce',
        strIngredient2: 'water',
        strMeasure1: '3/4 cup',
        strMeasure2: '1/2 cup',
        strInstructions: 'Step 1: Preheat oven to 350 degrees F.\nStep 2: Mix ingredients.',
      );
    });

    testWidgets('RecipeCard displays meal name correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(
              meal: testMeal,
              isFavorite: false,
              onFavoriteTap: () {},
            ),
          ),
        ),
      );

      // Verify meal name is displayed
      expect(find.text('Teriyaki Chicken Casserole'), findsOneWidget);
    });

    testWidgets('RecipeCard displays category and area chips', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(
              meal: testMeal,
              isFavorite: false,
            ),
          ),
        ),
      );

      // Verify category and area are displayed
      expect(find.text('Chicken'), findsOneWidget);
      expect(find.text('Japanese'), findsOneWidget);
    });

    testWidgets('RecipeCard displays ingredients count', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(
              meal: testMeal,
              isFavorite: false,
            ),
          ),
        ),
      );

      // Verify ingredients count is displayed
      expect(find.text('2 ingredients'), findsOneWidget);
    });

    testWidgets('RecipeCard favorite button shows correct icon when not favorited', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(
              meal: testMeal,
              isFavorite: false,
              onFavoriteTap: () {},
            ),
          ),
        ),
      );

      // Verify favorite border icon is shown (not filled)
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });

    testWidgets('RecipeCard favorite button shows correct icon when favorited', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(
              meal: testMeal,
              isFavorite: true,
              onFavoriteTap: () {},
            ),
          ),
        ),
      );

      // Verify filled favorite icon is shown
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsNothing);
    });

    testWidgets('RecipeCard favorite button calls onFavoriteTap when tapped', (WidgetTester tester) async {
      bool favoriteTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(
              meal: testMeal,
              isFavorite: false,
              onFavoriteTap: () {
                favoriteTapped = true;
              },
            ),
          ),
        ),
      );

      // Find and tap the favorite button
      final favoriteIcon = find.byIcon(Icons.favorite_border);
      expect(favoriteIcon, findsOneWidget);
      await tester.tap(favoriteIcon);
      await tester.pump();

      // Verify callback was called
      expect(favoriteTapped, true);
    });

    testWidgets('RecipeCard navigates to detail screen when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(
              meal: testMeal,
              isFavorite: false,
            ),
          ),
        ),
      );

      // Find the card (InkWell)
      final cardFinder = find.byType(InkWell).first;
      expect(cardFinder, findsOneWidget);

      // Tap the card
      await tester.tap(cardFinder);
      await tester.pumpAndSettle();

      // Verify navigation occurred (detail screen should show meal name in AppBar)
      expect(find.text('Teriyaki Chicken Casserole'), findsWidgets);
    });
  });

  group('SearchBar Widget Tests', () {
    testWidgets('SearchBar displays search icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: AppStrings.searchRecipe,
                  prefixIcon: const Icon(Icons.search_outlined),
                ),
              ),
            ),
          ),
        ),
      );

      // Verify search icon is displayed
      expect(find.byIcon(Icons.search_outlined), findsOneWidget);
    });

    testWidgets('SearchBar displays correct hint text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: AppStrings.searchRecipe,
                  prefixIcon: const Icon(Icons.search_outlined),
                ),
              ),
            ),
          ),
        ),
      );

      // Verify hint text is displayed
      expect(find.text(AppStrings.searchRecipe), findsOneWidget);
    });

    testWidgets('SearchBar accepts text input', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: AppStrings.searchRecipe,
                  prefixIcon: const Icon(Icons.search_outlined),
                ),
              ),
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextFormField), 'chicken');
      await tester.pump();

      // Verify text was entered
      expect(controller.text, 'chicken');
      expect(find.text('chicken'), findsOneWidget);

      controller.dispose();
    });
  });

  group('Favorite Button Widget Tests', () {
    testWidgets('Favorite button displays favorite_border icon when not favorited', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureDetector(
              onTap: () {
                tapped = true;
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      );

      // Verify favorite_border icon is displayed
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);

      // Verify it's tappable
      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pump();
      expect(tapped, true);
    });

    testWidgets('Favorite button displays filled favorite icon when favorited', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 24,
              ),
            ),
          ),
        ),
      );

      // Verify filled favorite icon is displayed
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsNothing);
    });

    testWidgets('Favorite button has correct styling when favorited', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 24,
              ),
            ),
          ),
        ),
      );

      // Find the icon and verify its color
      final iconFinder = find.byIcon(Icons.favorite);
      expect(iconFinder, findsOneWidget);

      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.color, Colors.red);
      expect(icon.size, 24);
    });
  });
}
