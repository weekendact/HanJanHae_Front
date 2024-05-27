import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  final String baseUrl =
      'http://10.200.32.76:8080'; // Update with your actual API URL

  String? _cocktailName; // Variable to store cocktail name

  // Getter to return database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Method to initialize database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'recipe_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Method called on database creation
  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE recipes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          image TEXT
        )
      ''');
  }

  // Method to insert recipe into database
  Future<int> insertRecipe(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('recipes', row);
  }

  // Method to query all recipes from database
  Future<List<Map<String, dynamic>>> queryAllRecipes() async {
    Database db = await database;
    return await db.query('recipes');
  }

  // Method to update recipe in the database
  Future<int> updateRecipe(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('recipes', row, where: 'id = ?', whereArgs: [id]);
  }

  // Method to delete recipe from the database
  Future<int> deleteRecipe(int id) async {
    Database db = await database;
    return await db.delete('recipes', where: 'id = ?', whereArgs: [id]);
  }

  // Method to fetch image from the server
  Future<String?> fetchImage(int id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/drink/cocktails/search'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': id}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['image_url'] as String?;
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Failed to load image: $e');
    }
  }

  // Method to fetch all recipes from the server
  Future<List<dynamic>> fetchRecipes() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/recipes'), // API endpoint
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }

  // Method to fetch details of a specific recipe from the server
  Future<Map<String, dynamic>> fetchRecipeDetails(String cocktailName) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/drink/cocktails/search'), // API endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'cocktailName': cocktailName}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        data['name'] = data['name'] ??
            'Unknown Cocktail'; // Store cocktail name received from API
        data['image_url'] =
            data['image_url'] ?? ''; // Handle null or missing image_url
        data.forEach((key, value) {
          if (value == null) {
            data[key] = 'No details available';
          }
        });

        _cocktailName =
            data['cocktailName']; // Store cocktail name received from API
        return data;
      } else {
        throw Exception(
            'Failed to load recipe details: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Failed to load recipe details: $e');
    }
  }

  // Method to add a recipe to the server
  Future<void> addRecipe(Map<String, dynamic> recipe) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/recipes/add'), // API endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode(recipe),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add recipe: ${response.statusCode}');
      }

      // If added successfully, store in local database
      await insertRecipe(recipe);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Failed to add recipe: $e');
    }
  }

  // Method to update a recipe on the server
  Future<void> updateRecipeApi(int id, Map<String, dynamic> recipe) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/recipes/update'), // API endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': id, ...recipe}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update recipe: ${response.statusCode}');
      }

      // If updated successfully, update local database
      await updateRecipe(recipe);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Failed to update recipe: $e');
    }
  }

  // Method to delete a recipe from the server
  Future<void> deleteRecipeApi(int id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/recipes/delete'), // API endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': id}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete recipe: ${response.statusCode}');
      }

      // If deleted successfully, delete from local database
      await deleteRecipe(id);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Failed to delete recipe: $e');
    }
  }

  // Method to return cocktail name
  String? get cocktailName => _cocktailName;

  // Method to fetch cocktail name and picture from the server based on drink type
  Future<Map<String, dynamic>> fetchCocktailNameAndPicture(
      String drinkType) async {
    try {
      final response = await http.post(
        Uri.parse(
            '$baseUrl/drinkType'), // Update with appropriate endpoint for drinkType
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'drinkType': drinkType}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        String name = data['cocktailName'] ??
            'Unknown Cocktail'; // Store cocktail name received from API
        String? picture =
            data['cocktailPicture']; // Store cocktail picture received from API
        return {'name': name, 'picture': picture};
      } else {
        throw Exception(
            'Failed to load cocktail details: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Failed to load cocktail details: $e');
    }
  }
}
