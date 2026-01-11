// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:recipe_finder_app/features/recipes/data/models/meal_model.dart';
import 'package:recipe_finder_app/features/recipes/presentation/widgets/recipe_detail_screen.dart';

class RecipeCard extends StatefulWidget {
  final MealModel meal;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const RecipeCard({
    super.key,
    required this.meal,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailScreen(meal: widget.meal),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Favorite Icon
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: widget.meal.strMealThumb != null
                    ? Image.network(
                        widget.meal.strMealThumb!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported),
                          );
                        },
                      )
                    : Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      ),
              ),
              // Favorite Icon
              if (widget.onFavoriteTap != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: widget.onFavoriteTap,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.isFavorite ? Colors.red : Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Meal Name
                Text(
                  widget.meal.strMeal ?? 'Unknown Meal',

                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                // Category and Area
                Row(
                  children: [
                    if (widget.meal.strCategory != null) ...[
                      Chip(
                        label: Text(widget.meal.strCategory!),
                        backgroundColor: Colors.orange.shade100,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      SizedBox(width: 8),
                    ],
                    if (widget.meal.strArea != null) ...[
                      Chip(
                        label: Text(widget.meal.strArea!),
                        backgroundColor: Colors.blue.shade100,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 12),
                // Ingredients count
                Row(
                  children: [
                    Icon(Icons.restaurant_menu, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      '${widget.meal.getIngredients().length} ingredients',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }
}
