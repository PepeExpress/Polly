import 'package:path/path.dart';
import 'package:plant_classification/model/plants.dart';
import 'package:sqflite/sqflite.dart';

class PlantsDatabase {
  static final PlantsDatabase instance = PlantsDatabase._init();

  static Database? _database;

  PlantsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('plants.db');
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
    CREATE TABLE $tablePlants (
        ${PlantFields.id} $idType,
        ${PlantFields.discovered} $boolType,
        ${PlantFields.discoveredTime} $textType,
        ${PlantFields.name} $textType,
        ${PlantFields.description} $textType,
        ${PlantFields.urlImage} $textType,
        ${PlantFields.urlWikipedia} $textType,
        ${PlantFields.classificationResults} $textType
      )
      ''');
    await populate(initialItems, db);
  }

  Future<Plant> create(Plant plant) async {
    final db = await instance.database;

    final id = await db.insert(tablePlants, plant.toJson());
    return plant.copy(id: id);
  }

  Future populate(List<Plant> plants, Database db) async {
    plants.forEach((element) async {
      final id = await db.insert(tablePlants, element.toJson());
      element.copy(id: id);
    });
  }

  Future<Plant> readPlant(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablePlants,
      columns: PlantFields.values,
      where: '${PlantFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Plant.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Plant>> readAllPlants() async {
    final db = await instance.database;

    final result = await db.query(tablePlants);

    return result.map((json) => Plant.fromJson(json)).toList();
  }

  Future<int> update(Plant plant) async {
    final db = await instance.database;

    return db.update(
      tablePlants,
      plant.toJson(),
      where: '${PlantFields.id} = ?',
      whereArgs: [plant.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db
        .delete(tablePlants, where: '${PlantFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  var initialItems = [
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Orchidea',
      description: 'description',
      urlImage:
          'https://www.giardinaggio.it/appartamento/piante/orchidee/orchidee_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Orchidaceae',
      classificationResults: List.empty(),
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Iris',
      description: 'description',
      urlImage:
          'https://www.viridea.it/wp-content/uploads/2019/06/consigli-piante-IRIS-e1499348343747.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Iris_(botanica)',
      classificationResults: ['iris'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Cipolla',
      description: 'description',
      urlImage:
          'https://www.giardinaggio.net/orto/coltivare-orto/coltivazione-cipolle_NCG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Allium_cepa',
      classificationResults: ['allium'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Giglio',
      description: 'description',
      urlImage: 'https://www.lafiorista.it/foto-blog-fiori/20200624_giglio.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Lilium',
      classificationResults: ['lilium'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Euforbia',
      description: 'description',
      urlImage:
          'https://www.hotelgabbianoazzurro.com/Cms_Data/Contents/hga-mobile-en/Folders/Blog/~contents/4B82TBRV74LWTCQW/cdg-f-euforbia-cipressina_002.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Euphorbia',
      classificationResults: ['euphorbia'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Globularia',
      description: 'description',
      urlImage: 'https://www.casaegiardino.it/images/2019/03/Globularia.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Globularieae',
      classificationResults: List.empty(),
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Mimosa',
      description: 'description',
      urlImage:
          'https://www.quibrescia.it/photogallery_new/images/2017/03/mimose-517244.660x368.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Acacia_dealbata',
      classificationResults: ['Acacia farnesiana'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Leguminose',
      description: 'description',
      urlImage:
          'https://images-na.ssl-images-amazon.com/images/I/61jOasylTlL._AC_.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Fabaceae',
      classificationResults: ['lupinus', 'melilotus'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Sambuco',
      description: 'description',
      urlImage:
          'https://www.inherba.it/wp-content/uploads/2017/09/sambuco-1-600x400.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Sambucus',
      classificationResults: ['sambucus'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Carota',
      description: 'description',
      urlImage:
          'https://www.coltivazionebiologica.it/wp-content/uploads/2020/02/Carota-selvatica.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Daucus_carota',
      classificationResults: ['Daucus carota'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Cardo',
      description: 'description',
      urlImage:
          'https://www.inherba.it/wp-content/uploads/2014/09/cardo-marinao-art-2-1024x683.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Carduus',
      classificationResults: ['cirsium'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Margherita',
      description: 'description',
      urlImage:
          'https://www.ilgiardinodegliilluminati.it/wp-content/uploads/2019/02/margherita-significato-e-simbologia.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Leucanthemum_vulgare',
      classificationResults: [
        'Leucanthemum vulgare',
        'Corethrogyne filaginifolia',
        'Bellis perennis'
      ],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Tarassaco',
      description: 'description',
      urlImage:
          'https://www.poderecadisopra.com/shop/wp-content/uploads/2020/03/Tarassaco-tanti-e1585730183536.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Taraxacum_officinale',
      classificationResults: ['Taraxacum officinale'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Polygala',
      description: 'description',
      urlImage: 'https://www.giardinaggio.it/giardino/piante/polygala_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Polygala',
      classificationResults: ['Leucophyllum frutescens', 'polygala'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Legumi',
      description: 'description',
      urlImage:
          'https://www.ponzaracconta.it/wp-content/uploads/2015/09/Lenticchia.-Fiore.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Fabaceae',
      classificationResults: ['lupinus', 'melilotus'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Verbascum',
      description: 'description',
      urlImage:
          'https://www.igiardinidellindaco.it/613-large_default/verbascum-nigrum-.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Verbascum',
      classificationResults: ['verbascum'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Veronica',
      description: 'description',
      urlImage:
          'https://www.giardinaggio.it/fiori/fiori-delle-piante/fiori-veronica_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Veronica_(botanica)',
      classificationResults: ['veronica'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Viola',
      description: 'description',
      urlImage:
          'https://www.ideegreen.it/wp-content/uploads/2016/03/viola-cornuta-1280x720.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Viola_tricolor',
      classificationResults: ['viola'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Bocca di leone',
      description: 'description',
      urlImage:
          'https://www.giardinaggio.net/giardino/piante-annuali/bocca-di-leone_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Antirrhinum_majus',
      classificationResults: ['Antirrhinum majus'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Senape',
      description: 'description',
      urlImage: 'https://www.casaegiardino.it/images/2018/09/Senape-fiore.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Senape',
      classificationResults: ['brassica'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Cappero',
      description: 'description',
      urlImage:
          'https://www.coltivare.info/wp-content/uploads/2019/01/capperi-2.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Capparis_spinosa',
      classificationResults: ['Capparis spinosa'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Vitalbe',
      description: 'description',
      urlImage:
          'https://file.cure-naturali.it/site/image/content/18853.jpg?format=jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Clematis_vitalba',
      classificationResults: ['Clematis vitalba'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Papavero',
      description: 'description',
      urlImage:
          'https://www.macrolibrarsi.it/data/staff-upload/legacy/p/pa/papavero-min.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Papaver',
      classificationResults: ['papaver'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Lleboro',
      description: 'description',
      urlImage: 'https://www.giardinaggio.it/giardino/piante/elleboro_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Helleborus',
      classificationResults: List.empty(),
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Acetoselle',
      description: 'description',
      urlImage:
          'https://www.coltivazionebiologica.it/wp-content/uploads/2019/03/Acetosella-1-e1552807993667-1200x801.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Oxalis_acetosella',
      classificationResults: ['oxalis'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Garofano',
      description: 'description',
      urlImage:
          'https://i2.wp.com/www.natural-magazine.it/wp-content/uploads/2019/07/garofano.jpg?resize=1200%2C720&ssl=1',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Dianthus',
      classificationResults: List.empty(),
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Cisto',
      description: 'description',
      urlImage:
          'https://www.ideegreen.it/wp-content/uploads/2019/06/cistus-cisto-pianta.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Cistus',
      classificationResults: List.empty(),
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Malva',
      description: 'description',
      urlImage:
          'https://www.alchemillaelba.com/Product/1366/malva-fiori-e-foglie--prezzo-per-100-g-92742016-big.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Malva',
      classificationResults: ['malva'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Ranuncolo',
      description: 'description',
      urlImage:
          'https://www.tuttogreen.it/wp-content/uploads/2019/02/shutterstock_1697183059.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Ranunculus',
      classificationResults: ['ranunculus'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Rosa',
      description: 'description',
      urlImage:
          'https://www.ilgiardinodegliilluminati.it/wp-content/uploads/2019/03/rosa-significato-e-simbologia.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Rosa_(botanica)',
      classificationResults: ['rosa'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Campanella',
      description: 'description',
      urlImage:
          'https://www.giardinaggio.net/giardino/piante-annuali/campanella_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Campanula',
      classificationResults: ['campanula'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Borraggine',
      description: 'description',
      urlImage:
          'https://www.giardinaggio.net/orto/aromatiche/borragine_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Borago_officinalis',
      classificationResults: ['Borago officinalis'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Pomodoro',
      description: 'description',
      urlImage:
          'https://www.coltivazionebiologica.it/wp-content/uploads/2016/05/Fiori-di-pomodoro-2-e1586074422301.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Solanum_lycopersicum',
      classificationResults: ['solanum'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Vinca',
      description: 'description',
      urlImage:
          'https://cdn.cosedicasa.com/wp-content/uploads/2020/04/pervinca.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Vinca',
      classificationResults: ['Catharanthus roseus', 'vinca'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Primula',
      description: 'description',
      urlImage:
          'https://www.coltivazionebiologica.it/wp-content/uploads/2020/12/Primula.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Primula',
      classificationResults: ['primula'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Genziana',
      description: 'description',
      urlImage:
          'https://www.greenme.it/wp-content/uploads/2017/03/genziana_cover-1200x720.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Gentiana',
      classificationResults: ['gentiana'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Narciso',
      description: 'description',
      urlImage:
          'https://www.tuttogreen.it/wp-content/uploads/2017/09/shutterstock_1521949868.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Narcissus',
      classificationResults: ['Narcissus pseudonarcissus'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Peonia',
      description: 'description',
      urlImage:
          'https://res.cloudinary.com/greenplanner/images/f_auto,q_auto/v1590684838/peonia/peonia.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Paeonia',
      classificationResults: List.empty(),
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Ninfea',
      description: 'description',
      urlImage: 'https://www.giardinaggio.it/giardino/piante/ninfee_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Nymphaea',
      classificationResults: ['nymphaea'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Melograno',
      description: 'description',
      urlImage:
          'https://trea-agricoltura.it/wp-content/uploads/2020/12/melograno-da-fiore.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Punica_granatum',
      classificationResults: ['Punica granatum'],
    )
  ];
}
