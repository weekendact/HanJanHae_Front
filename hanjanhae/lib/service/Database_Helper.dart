import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class databasehelper {
  static final databasehelper _instance = databasehelper._internal();

  factory databasehelper() {
    return _instance;
  }

  databasehelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cocktails (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imageAsset TEXT,
            cocktailName TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertCocktail(String imageAsset, String cocktailName) async {
    Database db = await database;
    await db.insert(
      'cocktails',
      {'imageAsset': imageAsset, 'cocktailName': cocktailName},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getCocktails() async {
    Database db = await database;
    return await db.query('cocktails');
  }
}
