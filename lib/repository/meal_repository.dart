import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/meal.dart';

class MealRepository {
  final String baseUrl = "https://www.themealdb.com/api/json/v1/1";

  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search.php?s=$query'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      if (body['meals'] == null) {
        return [];
      }

      final List<dynamic> meals = body['meals'];
      debugPrint('Found ${meals.length} meals');

      return meals.map((dynamic item) => Meal.fromJson(item)).toList();
    } else {
      throw Exception('Failed to find searched meal(s)');
    }
  }

  Future<Meal?> getMealById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/lookup.php?i=$id'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      if (body['meals'] == null || body['meals'].isEmpty) {
        return null;
      }

      return Meal.fromJson(body['meals'][0]);
    } else {
      throw Exception('Failed to load meal');
    }
  }

  // retrieves the random meal
  Future<Meal> getRandomMeal() async {
    final response = await http.get(
      Uri.parse('$baseUrl/random.php'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      return Meal.fromJson(body['meals'][0]);
    } else {
      throw Exception('Failed to load random meal');
    }
  }


  Future<List<Meal>> filterByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$baseUrl/filter.php?c=$category'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      if (body['meals'] == null) {
        return [];
      }

      final List<dynamic> meals = body['meals'];
      return meals.map((dynamic item) => Meal.fromJson(item)).toList();
    } else {
      throw Exception('Failed to filter meals');
    }
  }

  Future<List<String>> getCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories.php')
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List<dynamic> categories = body['categories'];
      return categories
          .map((dynamic item) => item['strCategory'] as String)
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

}