// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/core/constants/app_strings.dart';
import 'package:recipe_finder_app/core/utils/colors.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/recipe_event.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/recipe_state.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  void initState() {
    super.initState();
    // Load categories and areas when filter bottom sheet opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<RecipeBloc>().state;
      if (state is RecipeLoaded) {
        // If categories or areas are not loaded, load them
        if (state.categories == null) {
          context.read<RecipeBloc>().add(const LoadCategoriesEvent());
        }
        if (state.areas == null) {
          context.read<RecipeBloc>().add(const LoadAreasEvent());
        }
      } else {
        // If state is not RecipeLoaded, load both categories and areas
        context.read<RecipeBloc>().add(const LoadCategoriesEvent());
        context.read<RecipeBloc>().add(const LoadAreasEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        final categories = state is RecipeLoaded ? state.categories : null;
        final areas = state is RecipeLoaded ? state.areas : null;
        final selectedCategory = state is RecipeLoaded
            ? state.selectedCategory
            : null;
        final selectedArea = state is RecipeLoaded ? state.selectedArea : null;

        // Count active filters
        int activeFilterCount = 0;
        if (selectedCategory != null) activeFilterCount++;
        if (selectedArea != null) activeFilterCount++;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  if (activeFilterCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$activeFilterCount ${AppStrings.activeFilters.toLowerCase()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // Categories Section
              if (categories != null && categories.isNotEmpty) ...[
                Text(
                  AppStrings.filterByCategory,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected =
                          selectedCategory == category.strCategory;

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: FilterChip(
                          label: Text(category.strCategory ?? ''),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              context.read<RecipeBloc>().add(
                                FilterByCategoryEvent(category.strCategory!),
                              );
                            } else {
                              context.read<RecipeBloc>().add(
                                const ClearFiltersEvent(),
                              );
                            }
                            Navigator.pop(context);
                          },
                          selectedColor: greenColor.withOpacity(0.3),
                          checkmarkColor: greenColor,
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected ? greenColor : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Areas Section
              if (areas != null && areas.isNotEmpty) ...[
                Text(
                  AppStrings.filterByArea,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: areas.length,
                    itemBuilder: (context, index) {
                      final area = areas[index];
                      final isSelected = selectedArea == area.name;

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: FilterChip(
                          label: Text(area.name ?? ''),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              context.read<RecipeBloc>().add(
                                FilterByAreaEvent(area.name!),
                              );
                            } else {
                              context.read<RecipeBloc>().add(
                                const ClearFiltersEvent(),
                              );
                            }
                            Navigator.pop(context);
                          },
                          selectedColor: greenColor.withOpacity(0.3),
                          backgroundColor: Colors.white,
                          checkmarkColor: greenColor,
                          labelStyle: TextStyle(
                            color: isSelected ? greenColor : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Clear Filters Button
              if (activeFilterCount > 0)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<RecipeBloc>().add(const ClearFiltersEvent());
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      AppStrings.clearFilters,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
