import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/core/constants/app_strings.dart';
import 'package:recipe_finder_app/core/utils/colors.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/recipe_event.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/recipe_state.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/favorites_bloc.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/favorites_event.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/favorites_state.dart';
import 'package:recipe_finder_app/features/recipes/presentation/widgets/filter_bottom_sheet.dart';
import 'package:recipe_finder_app/features/recipes/presentation/widgets/recipe_card.dart';

class SearchScreen extends StatefulWidget {
  final String? selectedCategory;
  final String? selectedArea;

  const SearchScreen({
    super.key,
    this.selectedCategory,
    this.selectedArea,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Auto-focus and open keyboard when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      if (value.trim().isEmpty) {
        context.read<RecipeBloc>().add(LoadRecipesEvent());
      } else {
        context.read<RecipeBloc>().add(SearchRecipesEvent(value));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey.shade100,
        surfaceTintColor: Colors.grey.shade50,
        title: Text(
          AppStrings.searchRecipeHeading,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  // Search Bar
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      onChanged: _onSearchChanged,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: AppStrings.searchRecipe,
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade400,
                        ),
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          size: 30,
                          color: Colors.grey.shade400,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.7,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.7,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.7,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                //Filter button
                BlocBuilder<RecipeBloc, RecipeState>(
                  builder: (context, state) {
                    final selectedCategory = state is RecipeLoaded ? state.selectedCategory : null;
                    final selectedArea = state is RecipeLoaded ? state.selectedArea : null;
                    
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
                            child: const Icon(Icons.tune, color: Colors.white),
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
          ),
          // Search Results
          Expanded(
            child: BlocBuilder<RecipeBloc, RecipeState>(
              builder: (context, state) {
                if (state is RecipeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is RecipeError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        SizedBox(height: 16),
                        Text(
                          state.message,
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_searchController.text.trim().isEmpty) {
                              context.read<RecipeBloc>().add(
                                LoadRecipesEvent(),
                              );
                            } else {
                              context.read<RecipeBloc>().add(
                                SearchRecipesEvent(_searchController.text),
                              );
                            }
                          },
                          child: Text(AppStrings.retry),
                        ),
                      ],
                    ),
                  );
                } else if (state is RecipeLoaded) {
                  if (state.meals.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            AppStrings.noRecipesFound,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return BlocBuilder<FavoritesBloc, FavoritesState>(
                    builder: (context, favoritesState) {
                      final favoriteIds = favoritesState is FavoritesLoaded
                          ? favoritesState.favoriteIds
                          : <String>{};

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: state.meals.length,
                        itemBuilder: (context, index) {
                          final meal = state.meals[index];
                          final isFavorite = meal.idMeal != null
                              ? favoriteIds.contains(meal.idMeal)
                              : false;

                          return RecipeCard(
                            meal: meal,
                            isFavorite: isFavorite,
                            onFavoriteTap: () {
                              context.read<FavoritesBloc>().add(
                                    ToggleFavoriteEvent(meal),
                                  );
                            },
                          );
                        },
                      );
                    },
                  );
                } else if (state is FilteredMealsLoaded) {
                  // Handle filtered meals if needed
                  return Center(
                    child: Text(
                      'Filtered meals - need to fetch full details',
                    ),
                  );
                }

                // Initial state - show empty message
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, size: 64, color: Colors.grey[400]),
                      SizedBox(height: 16),
                      Text(
                        'Start typing to search recipes...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
