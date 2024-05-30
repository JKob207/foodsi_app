import 'package:flutter/material.dart';
import 'package:foodsi_app/views/categories_list.dart';
import 'package:foodsi_app/views/recipies_list.dart';

class NavigationBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Categories',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => const RecipiesList()),
            );
          } else if (index == 1) {
            Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const CategoriesList()),
            );
          }
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green,
        iconSize: 20,
      );
  }
}