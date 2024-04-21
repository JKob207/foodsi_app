import 'package:flutter/material.dart';

class RecipiesList extends StatefulWidget {
  const RecipiesList({super.key});

  @override
  State<RecipiesList> createState() => _RecipiesListState();
}

class _RecipiesListState extends State<RecipiesList> {
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
      )
    );
  }
}