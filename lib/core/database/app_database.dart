import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Centralized SQLite database connection for the app.

class AppDatabase {
  static const _databaseName = 'money_tracker.db';
  static const _databaseVersion = 1;

  static Database? _database;

  AppDatabase._();

  static Future<Database> get instance async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        description TEXT NOT NULL,
        dateTime TEXT NOT NULL
      )
    ''');
  }
}