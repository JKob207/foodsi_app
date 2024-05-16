import 'package:flutter/material.dart';
import 'package:foodsi_app/models/recipe.api.dart';
import 'package:foodsi_app/models/recipe.dart';
import 'package:foodsi_app/widgets/recipe_card.dart';

class RecipiesList extends StatefulWidget {
  const RecipiesList({super.key});

  @override
  State<RecipiesList> createState() => _RecipiesListState();
}

class _RecipiesListState extends State<RecipiesList> {

  late Future<List<Recipe>> _futureRecipies;

  @override
  void initState() {
    super.initState();

    _futureRecipies = RecipeApi.getRecipies();
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
        ],),
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
                return RecipeCard(
                  title: recipies[index].name,
                  cookTime: recipies[index].totalTime,
                  rating: recipies[index].rating.toString(),
                  thumbnailURL: recipies[index].images,
                );
              },
            );
          }
        },
      )
    );
  }
}