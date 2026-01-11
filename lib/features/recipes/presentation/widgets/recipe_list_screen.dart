import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/core/utils/colors.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/recipe_event.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/recipe_state.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/favorites_bloc.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/favorites_event.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/favorites_state.dart';
import 'package:recipe_finder_app/features/recipes/presentation/widgets/filter_bottom_sheet.dart';
import 'package:recipe_finder_app/features/recipes/presentation/widgets/recipe_card.dart';
import 'package:recipe_finder_app/features/recipes/presentation/widgets/search_screen.dart';

class RecipeListScreen extends StatefulWidget {
  final VoidCallback? onSearchTap;
  
  const RecipeListScreen({super.key, this.onSearchTap});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  @override
  void initState() {
    super.initState();
    // Load initial recipes when screen opens
    context.read<RecipeBloc>().add(LoadRecipesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello There,",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'What are you cooking today?',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade300,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset(
                            'assets/images/User.png',
                            width: 50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Search Bar
                        InkWell(
                          onTap: widget.onSearchTap,
                          child: Container(
                            height: 50,
                            width: size.width * 0.75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1.7,
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Icon(
                                  Icons.search_outlined,
                                  size: 30,
                                  color: Colors.grey.shade400,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Search recipe",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //Filter Button
                        BlocBuilder<RecipeBloc, RecipeState>(
                          builder: (context, state) {
                            final selectedCategory = state is RecipeLoaded
                                ? state.selectedCategory
                                : null;
                            final selectedArea = state is RecipeLoaded
                                ? state.selectedArea
                                : null;

                            // Count active filters
                            int activeFilterCount = 0;
                            if (selectedCategory != null) activeFilterCount++;
                            if (selectedArea != null) activeFilterCount++;

                            return InkWell(
                              onTap: () {
                                final recipeBloc = context.read<RecipeBloc>();
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (bottomSheetContext) =>
                                      BlocProvider.value(
                                        value: recipeBloc,
                                        child: const FilterBottomSheet(),
                                      ),
                                );
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: greenColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.tune,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // Active filter count indicator
                                  if (activeFilterCount > 0)
                                    Positioned(
                                      top: -4,
                                      right: -4,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 18,
                                          minHeight: 18,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '$activeFilterCount',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Trending Recipes",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Trending Recipes List
                    BlocBuilder<RecipeBloc, RecipeState>(
                      builder: (context, state) {
                        if (state is RecipeLoading) {
                          return Column(
                            children: [
                              SizedBox(height: 250),
                              Center(child: CircularProgressIndicator()),
                            ],
                          );
                        } else if (state is RecipeError) {
                          return Center(
                            child: Text(
                              'Error loading recipes',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (state is RecipeLoaded) {
                          if (state.meals.isEmpty) {
                            return Center(
                              child: Text(
                                'No recipes available',
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }

                          // Always show only 10 results
                          final itemCount = state.meals.length > 10
                              ? 10
                              : state.meals.length;
                          final hasMoreResults = state.meals.length > 10;

                          return BlocBuilder<FavoritesBloc, FavoritesState>(
                            builder: (context, favoritesState) {
                              final favoriteIds =
                                  favoritesState is FavoritesLoaded
                                  ? favoritesState.favoriteIds
                                  : <String>{};

                              return Column(
                                children: [
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: itemCount,
                                    itemBuilder: (context, index) {
                                      final meal = state.meals[index];
                                      final isFavorite = meal.idMeal != null
                                          ? favoriteIds.contains(meal.idMeal)
                                          : false;

                                      return RecipeCard(
                                        meal: meal,
                                        isFavorite: isFavorite,
                                        onFavoriteTap: () {
                                          log('Tapped');
                                          context.read<FavoritesBloc>().add(
                                            ToggleFavoriteEvent(meal),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  // Show "More Recipes....." if there are more than 10 results
                                  if (hasMoreResults)
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 16,
                                      ),
                                      child: Builder(
                                        builder: (builderContext) {
                                          final recipeBloc = builderContext
                                              .read<RecipeBloc>();
                                          final favoritesBloc = builderContext
                                              .read<FavoritesBloc>();
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MultiBlocProvider(
                                                        providers: [
                                                          BlocProvider.value(
                                                            value: recipeBloc,
                                                          ),
                                                          BlocProvider.value(
                                                            value: favoritesBloc,
                                                          ),
                                                        ],
                                                        child: SearchScreen(
                                                          selectedCategory: state
                                                              .selectedCategory,
                                                          selectedArea: state
                                                              .selectedArea,
                                                        ),
                                                      ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'More Recipes.....',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              );
                            },
                          );
                        }

                        return SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
