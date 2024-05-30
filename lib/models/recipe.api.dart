import 'dart:convert';
import 'package:foodsi_app/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:foodsi_app/models/recipe_category.dart';

class RecipeApi {

  static Future<List<Recipe>> getRecipies(String categoryTag) async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', {
      'limit': '24',
      'start': '0',
      'tag': categoryTag
    });

    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': '152ac0106dmsh41ab860fa196ac3p1bf2c9jsne6c9b9e93526',
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
    });
    
    Map data = jsonDecode(response.body);
    List _tmp = [];

    for(var i in data['feed'])
    {
      _tmp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_tmp);
  }

  static Future<List<RecipeCategory>> getCategoriesList() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', 'categories/list', {});

    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': '152ac0106dmsh41ab860fa196ac3p1bf2c9jsne6c9b9e93526',
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
    });
    
    Map data = jsonDecode(response.body);
    List _tmp = [];

    for(var i in data['browse-categories'])
    {
      if (i['display']['tag'].toString().startsWith('list.recipe')) {
        _tmp.add(i['display']);
      }
    }

    return RecipeCategory.categoriesFromSnapshot(_tmp);
  }
}