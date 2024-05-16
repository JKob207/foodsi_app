import 'package:flutter/material.dart';
import 'package:foodsi_app/models/recipe.dart';

class RecipeDetails extends StatelessWidget  {
  final Recipe recipe;

  const RecipeDetails({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
      ),
      body: Container(
        color: Colors.green,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side - Large image
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Image.network(
                      recipe.images,
                      width: double.infinity,
                      height: 200, // Adjust the height as needed
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Right side - Recipe details
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recipe name
                      Text(
                        recipe.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Rating and total time
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow),
                          const SizedBox(width: 4),
                          Text(recipe.rating.toString()),
                          const SizedBox(width: 16),
                          const Icon(Icons.access_time),
                          const SizedBox(width: 4),
                          Text(recipe.totalTime),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'List of Ingredients:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: recipe.keywords.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              const Icon(Icons.adjust, size: 12),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  recipe.keywords[index],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}