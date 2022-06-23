import 'package:sqflite/sqflite.dart';

import '../data/model/Res_List_Respon.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();
  static const String _tableFavorite = 'table_favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tableFavorite(
        id varchar PRIMARY KEY,
        name varchar,
        description varchar,
        pictureId varchar,
        city varchar,
        rating double
        )''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<List<Restaurant>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tableFavorite);

    return result.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db!.query(_tableFavorite, where: 'id =?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tableFavorite, restaurant.toJson());
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db!.delete(_tableFavorite, where: 'id = ?', whereArgs: [id]);
  }
}
