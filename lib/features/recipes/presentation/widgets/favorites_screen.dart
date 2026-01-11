import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/core/constants/app_strings.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/favorites_bloc.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/favorites_event.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/favorites_state.dart';
import 'package:recipe_finder_app/features/recipes/presentation/widgets/recipe_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.favorites,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoritesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else if (state is FavoritesLoaded) {
              if (state.favorites.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.noFavorites,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.noFavoritesMessage,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  final meal = state.favorites[index];
                  return RecipeCard(
                    meal: meal,
                    isFavorite: true,
                    onFavoriteTap: () {
                      context.read<FavoritesBloc>().add(
                            RemoveFavoriteEvent(meal.idMeal ?? ''),
                          );
                    },
                  );
                },
              );
            }

            // Initial state
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
