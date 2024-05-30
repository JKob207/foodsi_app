import 'package:flutter/material.dart';
import 'package:foodsi_app/models/recipe.api.dart';
import 'package:foodsi_app/models/recipe_category.dart';
import 'package:foodsi_app/views/recipies_list.dart';
import 'package:foodsi_app/widgets/appBar_widget.dart';
import 'package:foodsi_app/widgets/navigationBar_widget.dart';

class CategoriesList extends StatefulWidget {
 const CategoriesList({super.key});

 @override
 State<CategoriesList> createState() => _CategoriesListState(); 
}

class _CategoriesListState extends State<CategoriesList> {
  late Future<List<RecipeCategory>> _futureCategories;

  @override
  void initState() {
    super.initState();

    _futureCategories = RecipeApi.getCategoriesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: FutureBuilder<List<RecipeCategory>>(
        future: _futureCategories,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
             List<RecipeCategory> categories = snapshot.data ?? [];
             return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                RecipeCategory category = categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipiesList(category: category),
                      )
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        color: Colors.black26,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
             );
          }
        },
      ),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}