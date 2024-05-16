class Recipe {
  final String name;
  final String images;
  final double rating;
  final String totalTime;
  final dynamic keywords;

  Recipe({
    required this.name, 
    required this.images, 
    required this.rating, 
    required this.totalTime,
    required this.keywords,
  });

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
      name: json['name'] as String, 
      images: json['images'][0]['hostedLargeUrl'] as String, 
      rating: json['rating'] as double, 
      totalTime: json['totalTime'] as String,
      keywords: json['keywords'] as dynamic,
    );
  }

  static List<Recipe> recipesFromSnapshot(List<dynamic> snapshot) {
    return snapshot.map((data) => Recipe.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'Recipe {name: $name, image: $images, rating: $rating, totalTime: $totalTime, keywords: $keywords}';
  }
}