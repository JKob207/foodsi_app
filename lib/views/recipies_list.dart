import 'package:flutter/material.dart';
import 'package:foodsi_app/models/recipe.api.dart';
import 'package:foodsi_app/models/recipe.dart';
import 'package:foodsi_app/models/recipe_category.dart';
import 'package:foodsi_app/views/recipe_details.dart';
import 'package:foodsi_app/widgets/appBar_widget.dart';
import 'package:foodsi_app/widgets/recipe_card.dart';
import 'package:foodsi_app/widgets/navigationBar_widget.dart';

class RecipiesList extends StatefulWidget {
  final RecipeCategory? category;

  const RecipiesList({super.key, this.category});

  @override
  State<RecipiesList> createState() => _RecipiesListState();
}

class _RecipiesListState extends State<RecipiesList> {

  late Future<List<Recipe>> _futureRecipies;

  @override
  void initState() {
    super.initState();

    String categoryTag = widget.category?.tag ?? '';

    _futureRecipies = RecipeApi.getRecipies(categoryTag);
  }

  @override
  Widget build(BuildContext context) {
    String categoryTitle = widget.category?.name ?? 'Top choices';

    return Scaffold(
      appBar: AppBarWidget(),
      body: FutureBuilder<List<Recipe>>(
        future: _futureRecipies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Recipe> recipies = snapshot.data ?? [];
            return ListView.builder(
              itemCount: recipies.length + 1,
              itemBuilder: (context, index) {
                if(index == 0)
                {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      categoryTitle,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                Recipe recipe = recipies[index - 1];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute (
                        builder: (context) => RecipeDetails(recipe: recipe),
                      )
                    );
                  },
                  child: RecipeCard(
                    title: recipe.name,
                    cookTime: recipe.totalTime,
                    rating: recipe.rating.toString(),
                    thumbnailURL: recipe.images,
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: NavigationBarWidget()
    );
  }
}