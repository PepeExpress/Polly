import 'package:path/path.dart';
import 'package:plant_classification/model/badges.dart';
import 'package:sqflite/sqflite.dart';

class BadgesDatabase {
  static final BadgesDatabase instance = BadgesDatabase._init();

  static Database? _database;

  BadgesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('badges.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = await _getDbPath(filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future deleteDB(String path) async {
    await deleteDatabase(path);
  }

  Future<String> _getDbPath(String filePath) async {
    final dbPath = await getDatabasesPath();
    return join(dbPath, filePath);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
    CREATE TABLE $tableBadges (
        ${BadgeFields.id} $idType,
        ${BadgeFields.discovered} $boolType,
        ${BadgeFields.discoveredTime} $textType,
        ${BadgeFields.name} $textType,
        ${BadgeFields.description} $textType,
        ${BadgeFields.imagePath} $textType
      )
      ''');
    await populate(initialItems, db);
  }

  Future<Badge> create(Badge plant) async {
    final db = await instance.database;

    final id = await db.insert(tableBadges, plant.toJson());
    return plant.copy(id: id);
  }

  Future populate(List<Badge> plants, Database db) async {
    plants.forEach((element) async {
      final id = await db.insert(tableBadges, element.toJson());
      element.copy(id: id);
    });
  }

  Future<Badge> readPlant(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableBadges,
      columns: BadgeFields.values,
      where: '${BadgeFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Badge.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Badge>> readAllBadges() async {
    final db = await instance.database;

    final result = await db.query(tableBadges);

    return result.map((json) => Badge.fromJson(json)).toList();
  }

  Future<int> update(Badge badge) async {
    final db = await instance.database;

    return db.update(
      tableBadges,
      badge.toJson(),
      where: '${BadgeFields.id} = ?',
      whereArgs: [badge.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db
        .delete(tableBadges, where: '${BadgeFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  var initialItems = [
    Badge(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'La tua prima pianta! 🌱',
      description: "Ricevuto per aver trovato la tua prima pianta!",
      imagePath: 'assets/badges/badge1.svg',
    ),
    Badge(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: '3 in un giorno! 🌴 🌾 🌼',
      description:
          "Ricevuto per aver scoperto per la prima volta 3 diverse piante nello stesso giorno!",
      imagePath: 'assets/badges/badge2.svg',
    ),
    Badge(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Esperto 😎',
      description: "Ricevuto per aver scoperto più di 20 piante.",
      imagePath: 'assets/badges/badge3.svg',
    ),
  ];
}
