import 'package:path/path.dart';
import 'package:plant_classification/model/quotes.dart';
import 'package:sqflite/sqflite.dart';

class QuotesDatabase {
  static final QuotesDatabase instance = QuotesDatabase._init();

  static Database? _database;

  QuotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('quotes.db');
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

    await db.execute('''
    CREATE TABLE $tableQuotes (
        ${QuoteFields.id} $idType,
        ${QuoteFields.quote} $textType
      )
      ''');
    await populate(initialItems, db);
  }

  Future<Quote> create(Quote quote) async {
    final db = await instance.database;

    final id = await db.insert(tableQuotes, quote.toJson());
    return quote.copy(id: id);
  }

  Future populate(List<Quote> quotes, Database db) async {
    quotes.forEach((element) async {
      final id = await db.insert(tableQuotes, element.toJson());
      element.copy(id: id);
    });
  }

  Future<Quote> readQuote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableQuotes,
      columns: QuoteFields.values,
      where: '${QuoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Quote.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Quote>> readAllQuotes() async {
    final db = await instance.database;

    final result = await db.query(tableQuotes);

    return result.map((json) => Quote.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db
        .delete(tableQuotes, where: '${QuoteFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  var initialItems = [
    Quote(
      quote:
          "La maggior parte delle piante che ci circondano arrivano da altrove e l’uomo con i suoi spostamenti è stato lo strumento più efficiente per favorire questo movimento.\nHanno viaggiato sotto forma di semi nelle tasche, attaccate agli abiti o aggrappate ai mezzi di trasporto.",
    ),
    Quote(
      quote:
          "Il numero di specie vegetali sul pianeta Terra è in evoluzione continua, ad oggi se ne stimano all’incirca 350.000.",
    ),
    Quote(
      quote:
          "Il 70% dell'ossigeno che respiriamo è prodotto dell'oceano, grazie alla fotosintesi del plancton che rilascia ossigeno nell'atmosfera.",
    ),
    Quote(
      quote:
          "L'eucalipto è l'albero dalla crescita più rapida e può raggiungere i 10 metri in un solo anno.\nNel 1872, in Australia, è stato scoperto un eucalipto alto 150m! Al giorno d'oggi l'albero più alto è 'Hyperion' una sequoia di 115m.",
    ),
    Quote(
      quote:
          "Se le api scomparissero, i fiori non sarebbero più impollinati, non crescerebbero più i frutti e non ci sarebbe più cibo per noi e gli altri animali.",
    ),
  ];
}
