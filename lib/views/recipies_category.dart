import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodsi_app/models/recipe_category.dart';
import 'package:foodsi_app/models/recipe.api.dart';
import 'package:foodsi_app/models/recipe.dart';
import 'package:foodsi_app/views/recipe_details.dart';
import 'package:foodsi_app/widgets/recipe_card.dart';

class RecipiesCategory extends StatefulWidget {
  final RecipeCategory category;

  const RecipiesCategory({super.key, required this.category});

  @override
  State<RecipiesCategory> createState() => _RecipiesListState();
}

class _RecipiesListState extends State<RecipiesCategory> {

  late Future<List<Recipe>> _futureRecipies;
  late Future<List<RecipeCategory>> _futureCategories;

  @override
  void initState() {
    super.initState();

    String categoryTag = widget.category.tag;

    _futureRecipies = RecipeApi.getRecipies(categoryTag);
    _futureCategories = RecipeApi.getCategoriesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.restaurant_menu),
          SizedBox(width: 10),
          Text('Foodsi'),
          ],
        ),
        actions: [
          FutureBuilder<List<RecipeCategory>>(
            future: _futureCategories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<RecipeCategory> categories = snapshot.data ?? [];
                return PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) {
                    return categories.map((RecipeCategory category) {
                      return PopupMenuItem<String>(
                        value: category.name,
                        child: Text(category.name),
                      );
                    }).toList();
                  },
                );
              }
            })
        ],
      ),
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
              itemCount: recipies.length,
              itemBuilder: (context, index) {
                Recipe recipe = recipies[index];
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
      )
    );
  }
}