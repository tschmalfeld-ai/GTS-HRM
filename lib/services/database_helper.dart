import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/heart_rate_data.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('heart_rate.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE heart_rate_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        heart_rate INTEGER NOT NULL,
        timestamp INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertHeartRate(HeartRateData data) async {
    final db = await database;
    return await db.insert('heart_rate_data', data.toMap());
  }

  Future<List<HeartRateData>> getAllHeartRateData() async {
    final db = await database;
    final result = await db.query(
      'heart_rate_data',
      orderBy: 'timestamp DESC',
    );

    return result.map((map) => HeartRateData.fromMap(map)).toList();
  }

  Future<List<HeartRateData>> getHeartRateDataByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final db = await database;
    final result = await db.query(
      'heart_rate_data',
      where: 'timestamp BETWEEN ? AND ?',
      whereArgs: [start.millisecondsSinceEpoch, end.millisecondsSinceEpoch],
      orderBy: 'timestamp ASC',
    );

    return result.map((map) => HeartRateData.fromMap(map)).toList();
  }

  Future<int> deleteAllData() async {
    final db = await database;
    return await db.delete('heart_rate_data');
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
