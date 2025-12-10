import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/meal.dart';

class MealService {
  // Ambil semua menu
  static Future<List<Meal>> fetchAllMeals() async {
    final url = Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/search.php?s=");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch meals");
    }

    final data = json.decode(response.body);

    if (data['meals'] == null) {
      return []; // aman
    }

    return (data['meals'] as List)
        .map((meal) => Meal.fromJson(meal))
        .toList();
  }

  static Future<Meal> fetchMealDetail(String id) async {
  final url = Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id");

  final response = await http.get(url);

  if (response.statusCode != 200) {
    throw Exception("Failed to fetch detail");
  }

  final data = json.decode(response.body);

  return Meal.fromJson(data['meals'][0]);
}

static Future<List<String>> fetchCategories() async {
  final url = Uri.parse("https://www.themealdb.com/api/json/v1/1/list.php?c=list");

  final response = await http.get(url);
  if (response.statusCode != 200) throw Exception("Failed to load categories");

  final data = json.decode(response.body);
  final list = data['meals'] as List;

  return list.map((e) => e["strCategory"] as String).toList();
}


}
