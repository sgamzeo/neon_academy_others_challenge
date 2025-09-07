import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'asgard.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE heroes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            surname TEXT,
            age INTEGER,
            email TEXT
          )
        ''');
      },
    );

    return _db!;
  }

  Future<int> insertHero(Map<String, dynamic> hero) async {
    final db = await database;
    return await db.insert('heroes', hero);
  }

  Future<List<Map<String, dynamic>>> getHeroes() async {
    final db = await database;
    return await db.query('heroes');
  }

  Future<int> updateHero(int id, Map<String, dynamic> hero) async {
    final db = await database;
    return await db.update('heroes', hero, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteHero(int id) async {
    final db = await database;
    return await db.delete('heroes', where: 'id = ?', whereArgs: [id]);
  }
}
