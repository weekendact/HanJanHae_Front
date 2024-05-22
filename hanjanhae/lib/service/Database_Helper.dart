import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  // 엔드포인트 부분
  final String baseUrl = 'https://가나다라마바사.com'; // 여기에 실제 API URL을 입력

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

  Future<List<dynamic>> fetchRecipes() async {
    final response = await http.post(
      Uri.parse('$baseUrl/recipes'), // API 엔드포인트
      //Uri.parse('${ApiConstants.baseUrl}/recipes'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<Map<String, dynamic>> fetchRecipeDetails(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recipes/details'), // API 엔드포인트
      //Uri.parse('${ApiConstants.baseUrl}/recipes/details'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': id}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load recipe details');
    }
  }

  Future<void> addRecipe(Map<String, dynamic> recipe) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recipes/add'), // API 엔드포인트
      //Uri.parse('${ApiConstants.baseUrl}/recipes/add'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(recipe),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add recipe');
    }
  }

  Future<void> updateRecipeApi(int id, Map<String, dynamic> recipe) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recipes/update'), // API 엔드포인트
      //Uri.parse('${ApiConstants.baseUrl}/recipes/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': id, ...recipe}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update recipe');
    }
  }

  Future<void> deleteRecipeApi(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recipes/delete'), // API 엔드포인트
      //Uri.parse('${ApiConstants.baseUrl}/recipes/delete'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': id}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete recipe');
    }
  }
}
