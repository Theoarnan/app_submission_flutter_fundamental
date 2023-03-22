import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalServices {
  static LocalServices? _localServices;
  static late Database _database;

  LocalServices._internal() {
    _localServices = this;
  }

  factory LocalServices() => _localServices ?? LocalServices._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableFavorite = 'favorite_restaurant';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'restaurant.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableFavorite (
               id TEXT PRIMARY KEY,
               name TEXT, 
               description TEXT, 
               city TEXT,
               pictureId TEXT,
               rating REAL
             )''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<List<RestaurantModel>> getAllFavoriteRestaurant() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableFavorite);
    List<RestaurantModel> data = results.isNotEmpty
        ? results.map((item) => RestaurantModel.fromJson(item)).toList()
        : [];
    return data;
  }

  Future<void> insertFavoriteRestaurant(RestaurantModel restaurant) async {
    final Database db = await database;
    await db.insert(_tableFavorite, restaurant.toMap());
  }

  Future<void> deleteFavoriteRestaurant(String idRestaurant) async {
    final db = await database;
    await db.delete(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [idRestaurant],
    );
  }

  Future<bool> checkIsFavoriteRestaurant(String idRestaurant) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [idRestaurant],
    );
    return results.isNotEmpty;
  }
}
