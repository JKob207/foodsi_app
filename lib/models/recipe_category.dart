class RecipeCategory {
  final String name;
  final String tag;

  RecipeCategory({
    required this.name,
    required this.tag,
  });

  factory RecipeCategory.fromJson(dynamic json) {
    return RecipeCategory(
      name: json['displayName'] as String? ?? '',
      tag: json['tag']  as String? ?? '', 
    );
  }

  static List<RecipeCategory> categoriesFromSnapshot(List<dynamic> snapshot) {
    return snapshot.map((data) => RecipeCategory.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'RecipeCategory {name: $name, tag: $tag}';
  }
}