import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/meal_model.dart';

class RecipeDetailScreen extends StatelessWidget {
  final MealModel meal;

  const RecipeDetailScreen({super.key, required this.meal});

  Future<void> _launchURL(String url, BuildContext context) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not launch $url'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error launching URL: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ingredientsWithMeasures = meal.getIngredientsWithMeasures();
    final steps = meal.getInstructionsSteps();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.strMeal ?? 'Recipe Details',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            if (meal.strMealThumb != null)
              Image.network(
                meal.strMealThumb!,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 64,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              )
            else
              Container(
                height: 300,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 64,
                    color: Colors.grey,
                  ),
                ),
              ),

            // Ingredients Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ingredients Heading
                  Text(
                    'Ingredients',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Ingredients List
                  if (ingredientsWithMeasures.isEmpty)
                    const Text(
                      'No ingredients available',
                      style: TextStyle(color: Colors.grey),
                    )
                  else
                    ...ingredientsWithMeasures.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: entry.key,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if (entry.value.isNotEmpty)
                                      TextSpan(
                                        text: ' - ${entry.value}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                  const SizedBox(height: 32),

                  // Steps Heading
                  Text(
                    'Steps',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Steps List
                  if (steps.isEmpty)
                    const Text(
                      'No instructions available',
                      style: TextStyle(color: Colors.grey),
                    )
                  else
                    ...steps.asMap().entries.map((entry) {
                      final index = entry.key + 1;
                      final step = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.orange.shade300,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '$index',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                step,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                  // YouTube Link Section
                  if (meal.strYoutube != null &&
                      meal.strYoutube!.trim().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 32),
                      child: InkWell(
                        onTap: () => _launchURL(meal.strYoutube!, context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.play_circle_filled,
                                color: Colors.white,
                                size: 28,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Watch Video Tutorial',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
