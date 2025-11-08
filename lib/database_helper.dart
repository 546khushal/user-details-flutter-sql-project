import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // --- Step 1: Create a private static instance ---
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // --- Step 2: Use a factory constructor to always return the same instance ---
  factory DatabaseHelper() {
    return _instance;
  }

  // --- Step 3: Private named constructor (can only be called inside this class) ---
  DatabaseHelper._internal();

  // --- Step 4: Declare the database variable ---
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), "users.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            email TEXT,
            password TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert("users", user);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query("users");
  }
  
  
  Future<Map<String, dynamic>?> getUserById(int id) async {
  final db = await database;
  List<Map<String, dynamic>> results =
      await db.query("users", where: "id = ?", whereArgs: [id]);
  if (results.isNotEmpty) {
    return results.first;
  }
  return null;
}

Future<int> updateUser(int id, Map<String, dynamic> user) async {
  final db = await database;
  return await db.update(
    "users",
    user,
    where: "id = ?",
    whereArgs: [id],
  );
}

Future<int> deleteUser(int id) async {
  final db = await database;
  return await db.delete(
    "users",
    where: "id = ?",
    whereArgs: [id],
  );
}

  
  
  
  
  
  
  
}
