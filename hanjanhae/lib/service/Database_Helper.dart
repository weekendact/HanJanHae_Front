import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'recipe_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE recipes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        image TEXT
      )
    ''');
  }

  Future<int> insertRecipe(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('recipes', row);
  }

  Future<List<Map<String, dynamic>>> queryAllRecipes() async {
    Database db = await database;
    return await db.query('recipes');
  }

  Future<int> updateRecipe(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('recipes', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteRecipe(int id) async {
    Database db = await database;
    return await db.delete('recipes', where: 'id = ?', whereArgs: [id]);
  }

  // API Helper methods
  final String baseUrl = 'https://yourapiurl.com'; // 여기에 실제 API URL을 입력하세요

  Future<List<dynamic>> fetchRecipes() async {
    final response = await http.get(Uri.parse('$baseUrl/recipes'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<Map<String, dynamic>> fetchRecipeDetails(int id) async {
    final response = await http.post(Uri.parse('$baseUrl/recipes/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }

  Future<void> addRecipe(Map<String, dynamic> recipe) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recipes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(recipe),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add recipe');
    }
  }

  Future<void> updateRecipeApi(int id, Map<String, dynamic> recipe) async {
    final response = await http.put(
      Uri.parse('$baseUrl/recipes/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(recipe),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update recipe');
    }
  }

  Future<void> deleteRecipeApi(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/recipes/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete recipe');
    }
  }
}
