class Meal {
  final String id;
  final String name;
  final String thumbnail;
  final String? category;
  final String instructions;
  final List<String> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.category,
    required this.instructions,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    // Extract ingredients (API punya 20 slot)
    List<String> ingredientList = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json["strIngredient$i"];
      final measure = json["strMeasure$i"];

      // Skip kalau bahan kosong
      if (ingredient != null &&
          ingredient.toString().isNotEmpty &&
          ingredient.toString() != "") {
        ingredientList.add("$ingredient - $measure");
      }
    }

    return Meal(
      id: json['idMeal'] ?? "",
      name: json['strMeal'] ?? "",
      thumbnail: json['strMealThumb'] ?? "",
      category: json['strCategory'] ?? "",
      instructions: json['strInstructions'] ?? "",
      ingredients: ingredientList,
    );
  }
}
