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
      description:
          "Le Orchidacee (Orchidaceae Juss., 1789) sono una famiglia di piante monocotiledoni, appartenenti all'ordine Asparagales. I loro fiori sono comunemente chiamati orchidee. Questa famiglia è costituita da piante erbacee perenni, alcune delle quali sono in grado di assorbire dall'acqua presente nell'ambiente le sostanze necessarie alla loro sopravvivenza tramite le radici aeree (autotrofia) e capaci anche di nutrirsi assimilando sostanze da organismi in decomposizione (sapròfite).",
      urlImage:
          'https://www.giardinaggio.it/appartamento/piante/orchidee/orchidee_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Orchidaceae',
      classificationResults: List.empty(),
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Iris',
      description:
          "Iris L., 1753 è un genere di piante della famiglia delle Iridaceae, che comprende oltre 300 specie, molte delle quali comunemente note come giaggioli. Il nome del genere deriva dalla parola greca iris che significa arcobaleno.\nIl genere è caratterizzato da un fiore attinomorfo (a simmetria raggiata) con petali saldati alla base in un breve tubo. I petali esterni sono ripiegati verso il basso, e sono dotati di una fascia di papille chiare; i petali interni sono ripiegati verso l'alto. Lo stilo è diviso in 3 porzioni coprenti gli stami.",
      urlImage:
          'https://www.viridea.it/wp-content/uploads/2019/06/consigli-piante-IRIS-e1499348343747.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Iris_(botanica)',
      classificationResults: ['iris'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Cipolla',
      description:
          "La cipolla (Allium cepa L.) è una pianta bulbosa tradizionalmente attribuita alla famiglia delle Liliaceae, secondo schemi tassonomici più recenti da inserire tra le Amaryllidaceae, vive sotto terra ed è formata da foglie modificate, che presentano un'epidermide (protezione). È una pianta erbacea biennale il cui ciclo di vita, in coltivazione, viene interrotto a un anno al fine di destinarla al consumo. Ha radici superficiali, con foglie che si ingrossano nella porzione basale dando la parte commestibile. Forma un lungo stelo fiorale che porta un'infiorescenza a ombrello con fiori di colore bianco-giallastro. Il frutto è una capsula. Il suo utilizzo principale è quello di alimento e condimento, ma è anche adoperata a scopo terapeutico per le proprietà attribuitele dalla scienza e dalle tradizioni della medicina popolare.",
      urlImage:
          'https://www.giardinaggio.net/orto/coltivare-orto/coltivazione-cipolle_NCG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Allium_cepa',
      classificationResults: ['allium'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Giglio',
      description:
          "Il giglio (Lilium L., 1753) è un genere di piante appartenente alla famiglia Liliaceae. Come l'iris, il genere Lilium è originario dell'Europa, dell'Asia e del Nord America; comprende piante con un'altezza da 80 cm a 2 m, dotate di bulbo a scaglie imbricate, disposte intorno ad un disco centrale, da cui originano inferiormente le radici, e superiormente lo stelo. Le scaglie, a seconda della specie, sono più o meno larghe, acuminate, serrate tra loro. Le radici del bulbo sono perenni e non si rinnovano tutti gli anni come succede solitamente nelle piante bulbose; solo i gigli di origine cinese e giapponese, alla ripresa vegetativa, formano un palco di radici avventizie sullo stelo sopra il bulbo a fior di terra, che contribuiscono alla nutrizione delle parti aeree. Le foglie generalmente lanceolate, più o meno strette con venature parallele, sono disposte attorno al fusto eretto, a volte in palchi, solitamente in ordine sparso. I fiori hanno sei tepali (tre petali e tre sepali petaloidi), e sono terminali, spesso riuniti in numerose infiorescenze portate da lunghi steli, con forme e colori diversissimi, e spesso profumatissimi. Il genere comprende circa 80 specie e numerosi ibridi e cultivar.",
      urlImage: 'https://www.lafiorista.it/foto-blog-fiori/20200624_giglio.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Lilium',
      classificationResults: ['lilium'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Euforbia',
      description:
          "Il genere Euphorbia L. comprende un vasto numero di piante dicotiledoni della famiglia delle Euphorbiaceae, erbacee o legnose a seconda della specie.\nIl genere comprende piccoli alberi, arbusti, rampicanti e piante erbacee. Una percentuale significativa sono piante succulente, alcune delle quali assomigliano straordinariamente ai cacti nonostante non siano per nulla imparentate con questi ultimi, un esempio di evoluzione convergente. Ad eccezione di poche specie (es: E. hedytoides o E. curtisii), questo genere è composto da specie ermafrodite.",
      urlImage:
          'https://www.hotelgabbianoazzurro.com/Cms_Data/Contents/hga-mobile-en/Folders/Blog/~contents/4B82TBRV74LWTCQW/cdg-f-euforbia-cipressina_002.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Euphorbia',
      classificationResults: ['euphorbia'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Globularia',
      description:
          "Globularieae Rchb., 1837 è una tribù di piante spermatofite, dicotiledoni appartenenti alla famiglia delle Plantaginaceae.\nIl nome della tribù deriva dal suo genere tipo Globularia L. la cui etimologia fa riferimento alla particolare infiorescenza di queste piante: una piccola sfera o globo. Il primo botanico a nominare queste piante è stato il francese Joseph Pitton de Tournefort.",
      urlImage: 'https://www.casaegiardino.it/images/2019/03/Globularia.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Globularieae',
      classificationResults: List.empty(),
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Mimosa',
      description:
          "cacia dealbata Link, 1822 è una pianta alla famiglia delle Mimosaceae, comunemente conosciuta come mimosa. Nel linguaggio comune, il termine di mimosa è utilizzato per indicare, oltre a questa pianta, anche altre specie appartenenti al genere Acacia; nel linguaggio scientifico, tale termine si riferisce invece al genere Mimosa.\nÈ una tipica pianta pioniera. È molto utilizzata come pianta ornamentale grazie alla sua profumata fioritura con fiori gialli molto delicati.",
      urlImage:
          'https://www.quibrescia.it/photogallery_new/images/2017/03/mimose-517244.660x368.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Acacia_dealbata',
      classificationResults: ['Acacia farnesiana'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Leguminose',
      description:
          "Le Fabacee (Fabaceæ, da faba = fava, una delle specie coltivate più antiche), o Leguminose (nom. cons.[1] leguminosæ, da legume, il frutto più tipico), o anche papilionacee (da papilio = farfalla, per la forma del fiore), sono una famiglia di piante dicotiledoni dell'ordine delle Fabales.\nNe fanno parte il fagiolo (Phaseolus vulgaris L.), il pisello (Pisum sativum L.), la fava (Vicia faba L.), il lupino (Lupinus), il cece (Cicer arietinum L.), il caiano (Cajanus indicus), l'arachide (Arachis hypogaea L.), la soia (Glycine max (L.) Merr.), la lenticchia (Lens culinaris), la cicerchia (Lathyrus sativus) e alberi come la mimosa (Acacia), albero di giuda (Cercis siliquastrum), la robinia (Robinia pseudoacacia), il carrubo (Ceratonia siliqua), il tamarindo (Tamarindus indica), la grenadilla (Dalbergia melanoxylon), il maggiociondolo (Laburnum anagyroides).",
      urlImage:
          'https://images-na.ssl-images-amazon.com/images/I/61jOasylTlL._AC_.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Fabaceae',
      classificationResults: ['lupinus', 'melilotus'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Sambuco',
      description:
          "Sambucus L. è un genere di piante ascritto alla famiglia delle Caprifoliacee. Comprende specie arbustive di medio-grandi dimensioni, talvolta in forma di piccolo albero con altezza di 5-10 metri, comunissimo lungo le siepi campestri, nei boschi planiziari e submontani e presso i casolari di campagna, nonché alla periferia delle città, dove rappresenta un relitto della vegetazione spontanea.",
      urlImage:
          'https://www.inherba.it/wp-content/uploads/2017/09/sambuco-1-600x400.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Sambucus',
      classificationResults: ['sambucus'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Carota',
      description:
          "La carota (Daucus carota L., 1753) è una pianta erbacea dal fusto di colore verde appartenente alla famiglia delle Apiaceae; è anche uno dei più comuni ortaggi, e il suo nome deriva dal latino tardo carōta, a sua volta dal gr. καρωτόν (karōton). La carota spontanea è diffusa in Europa, in Asia e nel Nord Africa. Ne esistono molte e diverse cultivar che sono coltivate in tutte le aree temperate del globo. Allo stato spontaneo è considerata pianta infestante e si trova facilmente in posti assolati ed in zone calde e sassose.",
      urlImage:
          'https://www.coltivazionebiologica.it/wp-content/uploads/2020/02/Carota-selvatica.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Daucus_carota',
      classificationResults: ['Daucus carota'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Cardo',
      description:
          "Carduus è un genere di piante angiosperma dicotiledone appartenenti alla famiglia delle Asteraceae, note come cardi, dall'aspetto di erbacee annuali o perenni, mediamente alte, in genere molto spinose e dai fiori simili al carciofo.",
      urlImage:
          'https://www.inherba.it/wp-content/uploads/2014/09/cardo-marinao-art-2-1024x683.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Carduus',
      classificationResults: ['cirsium'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Margherita',
      description:
          "La margherita diploide (nome scientifico Leucanthemum vulgare Lam., 1778) è una pianta erbacea della famiglia delle Asteraceae, comunissima nei prati della penisola italiana.\nSono piante alte mediamente 30 cm, al massimo 100 cm. La forma biologica della specie è emicriptofita scaposa (H scap); ciò significa che sono piante perennanti con gemme poste al livello del suolo con fusto allungato e poco foglioso. Possono essere glabre oppure leggermente tomentose.",
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
      description:
          "Il taràssaco comune (Taraxacum officinale [Weber ex Wiggers, 1780]) è una pianta a fiore (angiosperma) appartenente alla famiglia delle Asteracee. L'epiteto specifico, officinale, ne indica le virtù medicamentose, note fin dall'antichità e sfruttate con l'utilizzo delle sue radici e foglie.\nÈ comunemente conosciuto come dente di leone, dente di cane, soffione (l'infruttescenza), nonnino, cicoria selvatica, cicoria asinina, grugno di porco, ingrassaporci, brusaoci, insalata di porci, pisciacane, lappa, missinina, piscialletto, girasole dei prati, erba del porco o anche con lo storpiamento del nome in tarassàco.",
      urlImage:
          'https://www.poderecadisopra.com/shop/wp-content/uploads/2020/03/Tarassaco-tanti-e1585730183536.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Taraxacum_officinale',
      classificationResults: ['Taraxacum officinale'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Polygala',
      description:
          "Poligala (nome scientifico Polygala, L., 1753) è un genere di piante Spermatofite Dicotiledoni, arboree, erbacee, rampicanti e perenni, appartenente alla famiglia delle Polygalaceae.\nUn'antica credenza riteneva che tale erba fosse capace di aumentare la secrezione del latte alle mucche; da qui il nome del genere “Polygala” = molto latte. Dioscoride, riprendendo questa credenza, afferma che anche nelle gestanti faccia venire latte in abbondanza.",
      urlImage: 'https://www.giardinaggio.it/giardino/piante/polygala_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Polygala',
      classificationResults: ['Leucophyllum frutescens', 'polygala'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Legumi',
      description:
          "Le Fabacee (Fabaceæ, da faba = fava, una delle specie coltivate più antiche), o Leguminose (nom. cons.[1] leguminosæ, da legume, il frutto più tipico), o anche papilionacee (da papilio = farfalla, per la forma del fiore), sono una famiglia di piante dicotiledoni dell'ordine delle Fabales.\nNe fanno parte il fagiolo (Phaseolus vulgaris L.), il pisello (Pisum sativum L.), la fava (Vicia faba L.), il lupino (Lupinus), il cece (Cicer arietinum L.), il caiano (Cajanus indicus), l'arachide (Arachis hypogaea L.), la soia (Glycine max (L.) Merr.), la lenticchia (Lens culinaris), la cicerchia (Lathyrus sativus) e alberi come la mimosa (Acacia), albero di giuda (Cercis siliquastrum), la robinia (Robinia pseudoacacia), il carrubo (Ceratonia siliqua), il tamarindo (Tamarindus indica), la grenadilla (Dalbergia melanoxylon), il maggiociondolo (Laburnum anagyroides).",
      urlImage:
          'https://www.ponzaracconta.it/wp-content/uploads/2015/09/Lenticchia.-Fiore.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Fabaceae',
      classificationResults: ['lupinus', 'melilotus'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Verbascum',
      description:
          "Verbascum L. è un genere di piante della famiglia Scrophulariaceae.\nIl nome Verbascum deriva dalla radice virb (proprio anche alla Verbena) che significa verga. Il nome greco invece, phlomos, ha una radice preindoeuropea che è riconducibile a bhle, che significa gonfiarsi, ma anche brillare. Questo deriva dal fatto che la pianta era usata come stoppino per le lucerne fin da tempi antichissimi; anche in accadico il nome della pianta vuole dire lucerna.",
      urlImage:
          'https://www.igiardinidellindaco.it/613-large_default/verbascum-nigrum-.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Verbascum',
      classificationResults: ['verbascum'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Veronica',
      description:
          "Veronica L., 1753 è un genere di piante angiosperme dicotiledoni. I fiori vengono chiamati comunemente occhi della Madonna e sono confuse con il genere Myosotis. Fiore probabilmente dedicato a santa Veronica, protettrice della Francia.\nLa corolla è pentamera ma apparentemente si presenta a 4 lobi in quanto i due petali superiori sono fusi insieme; gli stami sono 2 saldati alla corolla. Il frutto è una capsula compressa lateralmente che contiene da 2 a 250 semi.",
      urlImage:
          'https://www.giardinaggio.it/fiori/fiori-delle-piante/fiori-veronica_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Veronica_(botanica)',
      classificationResults: ['veronica'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Viola',
      description:
          "Viola tricolor, chiamata anche viola del pensiero o viola tricolore, è una pianta della famiglia delle Violaceae, nota principalmente per il suo fiore.\nMolto comune in Europa, che cresce come pianta selvatica e perenne. È stata introdotta in Nord America, dove si è molto diffusa. È la progenitrice della viola del pensiero coltivata, ed è quindi a volte chiamata viola del pensiero selvatica; prima che si sviluppassero le viole coltivate, 'viola del pensiero' era un nome alternativo per la forma selvatica.",
      urlImage:
          'https://www.ideegreen.it/wp-content/uploads/2016/03/viola-cornuta-1280x720.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Viola_tricolor',
      classificationResults: ['viola'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Bocca di leone',
      description:
          "La bocca di leone comune (nome scientifico Antirrhinum majus L., 1753 ) è una pianta dai vistosi fiori colorati appartenente alla famiglia delle Plantaginaceae.\nIl nome generico (Antirrhinum) deriva da alcune parole greche il cui significato è “simile a un muso (o un naso)”, infatti “anti” = simile e “rhin” = naso e fa riferimento alla particolare forma della corolla definita anche 'personata'. La prima documentazione di questo nome si ha da Joseph Pitton de Tournefort (Aix-en-Provence, 5 giugno 1656 – Parigi, 28 dicembre 1708) un botanico francese; e prima ancora da Teofrasto (371 a.C. – Atene, 287 a.C.) un filosofo e botanico greco antico, discepolo di Aristotele, autore di due ampi trattati botanici. Anche Dioscoride (Anazarbe, 40 circa – 90 circa), medico, botanico e farmacista greco antico che esercitò a Roma ai tempi dell'imperatore Nerone, cita questa pianta affermando che il seme dell'Antirrino mescolato con olio di giglio rende più bella la faccia e la pelle. L'epiteto specifico (majus) deriva dal latino e significa 'più grande'.",
      urlImage:
          'https://www.giardinaggio.net/giardino/piante-annuali/bocca-di-leone_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Antirrhinum_majus',
      classificationResults: ['Antirrhinum majus'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Senape',
      description:
          "Con il nome senape si indicano alcune specie di piante erbacee appartenenti alla famiglia delle Brassicacee o Crocifere.\nLe piante di senape raramente raggiungono un'altezza superiore ai 2 metri, hanno foglie inferiori larghe pennatifide, mentre le superiori sono piccole e allungate. I'inflorescenza è gialla a forma di pannocchia. Esso sviluppa il frutto, che contiene numerosissimi semi piccoli e arrotondati da cui si ricava la famosa salsa di condimento, dal sapore tipicamente aspro e piccante.",
      urlImage: 'https://www.casaegiardino.it/images/2018/09/Senape-fiore.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Senape',
      classificationResults: ['brassica'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Cappero',
      description: "description",
      urlImage:
          'https://www.coltivare.info/wp-content/uploads/2019/01/capperi-2.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Capparis_spinosa',
      classificationResults: ['Capparis spinosa'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Vitalbe',
      description:
          "Il cappero (Capparis spinosa L., 1753) è un piccolo arbusto o suffrutice ramificato a portamento prostrato-ricadente della famiglia Capparaceae. Della pianta si consumano i boccioli, detti capperi, e più raramente i frutti, noti come cucunci. Entrambi si conservano sott'olio, sotto aceto o sotto sale.\nl portamento è cespitoso, con fusto subito ramificato e rami lignificati solo nella parte basale, spesso molto lunghi, dapprima eretti, poi striscianti o ricadenti.\nLe foglie sono alterne e picciolate, a lamina subrotonda e a margine intero, glabre o finemente pelose, di consistenza carnosa. La forma della lamina è ovata, il margine è liscio, le nervature sono pennate e non è una foglia composta. Il nome dato alla specie è dovuto alla presenza, alla base del picciolo, di due stipole trasformate in spine. Nella varietà inermis, la più comune, le stipole sono erbacee e cadono precocemente.",
      urlImage:
          'https://file.cure-naturali.it/site/image/content/18853.jpg?format=jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Clematis_vitalba',
      classificationResults: ['Clematis vitalba'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Papavero',
      description:
          "Papaver (L., 1753) , comunemente noto come papaveri, è un genere di piante erbacee appartenente alla famiglia delle Papaveraceae, diffuso in tutti i continenti.\nLa specie più nota è Papaver rhoeas, ovvero il papavero comune, specie messicola la cui fioritura è visibile nei campi della fascia temperata all'incirca da maggio.\nDescritto per la prima volta nel 1753 da Linneo nel suo Species Plantarum come composto da sole 8 specie, attualmente all'interno del genere Papaver ne sono incluse 252.",
      urlImage:
          'https://www.macrolibrarsi.it/data/staff-upload/legacy/p/pa/papavero-min.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Papaver',
      classificationResults: ['papaver'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Lleboro',
      description:
          "Helleborus (Tourn. ex L., 1753), comunemente noto come elleboro, è un genere di piante appartenente alla famiglia delle Ranunculaceae diffuso prevalentemente nel bacino del Mediterraneo, ad eccezione di una specie (H. thibetanus) che è presente in Estremo Oriente.\nI fiori dell'elleboro sono formati da 5 tepali che sono colorati in diversi modi e assumono spesso un aspetto petaloide. Questi circondano e proteggono i nettari che derivano dalla trasformazione dei veri petali. I tepali persistono dopo l'impollinazione, e studi condotti in Spagna suggeriscono che il perigonio persistente possa contribuire allo sviluppo dei semi. Alcune specie hanno radici rizomatose. La fioritura è invernale o ai primi tepori primaverili.",
      urlImage: 'https://www.giardinaggio.it/giardino/piante/elleboro_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Helleborus',
      classificationResults: List.empty(),
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Acetoselle',
      description:
          "L'Oxalis acetosella (nome comune Acetosella dei boschi) è una piccola pianta alta al massimo 12 cm, appartenente alla famiglia delle Oxalidaceae.\nIl nome del genere (Oxalis) deriva dal greco oxys (acuto o pungente) per il sapore acido della pianta e da hals (sale) per l'elevata quantità di acido ossalico.\nIl nome comune della pianta (acetosella) deriva dal sapore acidulo (ma anche aspro) delle foglie usate anticamente come condimento per le insalate e che ricorda appunto l'aceto.",
      urlImage:
          'https://www.coltivazionebiologica.it/wp-content/uploads/2019/03/Acetosella-1-e1552807993667-1200x801.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Oxalis_acetosella',
      classificationResults: ['oxalis'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Garofano',
      description:
          "Il garofano (Dianthus L.) è un genere della famiglia delle Caryophyllaceae, originario delle zone temperate del Globo.\nIl nome scientifico deriva dal greco antico 'dianthos' e significa 'fiore di Dio' (Zeus).\nIl genere comprende oltre 300 specie di piante erbacee o sublegnose, annuali, biennali e perenni, originarie delle zone temperate del globo, di altezza tra i 5 e i 100 cm; hanno fusti angolosi e nodosi, foglie opposte lineari o lanceolate, molli e piane, rigide e caniculate; fiori isolati o geminati a volte a capolini, con calice tubuloso e cilindrico, corolla a 5 petali con una lunga unghia; il frutto è una capsula uniloculare portante numerosissimi semi.",
      urlImage:
          'https://i2.wp.com/www.natural-magazine.it/wp-content/uploads/2019/07/garofano.jpg?resize=1200%2C720&ssl=1',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Dianthus',
      classificationResults: List.empty(),
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Cisto',
      description:
          "Cistus L., 1753 è un genere di piccoli arbusti o frutici sempreverdi appartenente alla famiglia delle Cistaceae.\nI cisti hanno fiori bellissimi vistosi, a simmetria raggiata, con calice persistente a 3-5 sepali, corolla dialipetala a 5 petali bianchi o rosei, androceo con numerosi stami poco sviluppati in lunghezza, ovario composto da 3-5 carpelli sormontato da uno stilo semplice.\nIl frutto è una capsula a 5 valve contenente più semi.\nÈ pianta mellifera, non di grande quantità, ma di ottima qualità di miele.",
      urlImage:
          'https://www.ideegreen.it/wp-content/uploads/2019/06/cistus-cisto-pianta.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Cistus',
      classificationResults: List.empty(),
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Malva',
      description:
          "Malva L. è un genere di piante della famiglia delle Malvaceae.\nLa Malva sylvestris, di origine probabilmente nordafricana (mauritiana) e/o sudeuropea, si è diffusa alle latitudini temperate subtropicali di ambedue gli emisferi. È pure oggetto di coltivazioni e viene importata prevalentemente dall'Europa Orientale e dai Balcani. Coltivata negli Stati Uniti d'America si è diffusa nel territorio ma non viene considerata naturalizzata.",
      urlImage:
          'https://www.alchemillaelba.com/Product/1366/malva-fiori-e-foglie--prezzo-per-100-g-92742016-big.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Malva',
      classificationResults: ['malva'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Ranuncolo',
      description:
          "Ranunculus (L., 1753) è un genere di piante erbacee appartenente alla famiglia delle Ranunculaceae, che comprende oltre 1600 specie (il numero è variabile secondo le varie classificazioni) originarie delle zone temperate e fredde del globo.\nI ranuncoli sono fiori semplici ma eleganti provenienti dall'Asia. La conoscenza di queste piante è molto antica. I turchi chiamavano queste piante “fiori doppi di Tripoli”; mentre lo scrittore e filosofo romano Apuleio (125 – 170) le nominava come “erba scellerata” a causa della loro tossicità; i greci, più anticamente, avevano invece trovato il nome di “batrachion” (vedi paragrafo seguente). Così con queste informazioni il botanico italiano Paolo Bartolomeo Clarici (1664 – 1725) introduce la descrizione del ranuncolo in un suo scritto.",
      urlImage:
          'https://www.tuttogreen.it/wp-content/uploads/2019/02/shutterstock_1697183059.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Ranunculus',
      classificationResults: ['ranunculus'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Rosa',
      description:
          "Rosa L., 1753 è un genere della famiglia delle Rosacee che comprende circa 150 specie, originarie dell'Europa e dell'Asia.\nComprende specie cespugliose, sarmentose, rampicanti, striscianti, arbusti e alberelli a fiore grande o piccolo, a mazzetti, pannocchie o solitari, semplici o doppi, frutti ad achenio contenuti in un falso frutto (cinorrodo); le specie spontanee in Italia sono oltre 30, di cui ricordiamo la R. canina (la più comune), la R. gallica (poco comune nelle brughiere e luoghi sassosi), la R. glauca (frequente sulle Alpi), la R. pendulina (comune sulle Alpi e l'Appennino settentrionale) e la R. sempervirens",
      urlImage:
          'https://www.ilgiardinodegliilluminati.it/wp-content/uploads/2019/03/rosa-significato-e-simbologia.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Rosa_(botanica)',
      classificationResults: ['rosa'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Campanella',
      description:
          "Campanula (Campanula L., 1753) è un genere di piante spermatofite dicotiledoni appartenenti alla famiglia delle Campanulaceae (sottofamiglia Campanuloideae), dall'aspetto di erbacee annuali/bienni o perenni dal tipico fiore a forma di campana.\nIl nome del genere (“campanula”) deriva dalla forma a campana del fiore; in particolare il vocabolo deriva dal latino e significa: piccola campana.\nDalle documentazioni risulta che il primo ad usare il nome botanico di “Campanula” sia stato il naturalista belga Rembert Dodoens, vissuto fra il 1517 e il 1585. ",
      urlImage:
          'https://www.giardinaggio.net/giardino/piante-annuali/campanella_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Campanula',
      classificationResults: ['campanula'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Borraggine',
      description:
          "La borragine (Borago officinalis L.) è una pianta erbacea annuale della famiglia delle Boraginaceae.\nl nome deriva dal latino borra (tessuto di lana ruvida), per la peluria che ricopre le foglie. Altri lo fanno derivare dall'arabo abu araq (= padre del sudore), attraverso il latino medievale borrago, forse per le proprietà sudorifere della pianta.",
      urlImage:
          'https://www.giardinaggio.net/orto/aromatiche/borragine_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Borago_officinalis',
      classificationResults: ['Borago officinalis'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Pomodoro',
      description:
          "Il pomodoro (Solanum lycopersicum, L. 1753) - identificato secondo il Codice Internazionale di Nomenclatura Botanica (ICBN) Lycopersicon esculentum (L.) Karsten ex Farw. (cfr. classificazione botanica), della famiglia delle Solanaceae, è una pianta annuale. Le sue bacche, dal caratteristico colore rosso, sono largamente utilizzate in ambito alimentare in molti Paesi del mondo.\nIl pomodoro è una bacca nativa della zona dell'America centrale, del Sudamerica e della parte meridionale dell'America Settentrionale. Gli Aztechi lo chiamarono xitomatl, mentre il termine tomatl indicava vari frutti simili fra loro, in genere sugosi.",
      urlImage:
          'https://www.coltivazionebiologica.it/wp-content/uploads/2016/05/Fiori-di-pomodoro-2-e1586074422301.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Solanum_lycopersicum',
      classificationResults: ['solanum'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Vinca',
      description:
          "Vinca L., 1753 è un genere di piante della famiglia delle Apocynaceae, originario dell'Europa e dei tropici, comprendente specie erbacee perenni, erette o striscianti, note con il nome comune di pervinca.\nL'origine del nome scientifico è incerta. Secondo alcune fonti deriva dal latino vincire (= legare), per la capacità della pianta di ancorarsi al terreno con le numerosi radici, o da vincus (=flessibile), con riferimento ai fusti sottili e flessibili.",
      urlImage:
          'https://cdn.cosedicasa.com/wp-content/uploads/2020/04/pervinca.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Vinca',
      classificationResults: ['Catharanthus roseus', 'vinca'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Primula',
      description:
          "Primula L. è un genere di piante della famiglia delle Primulaceae, originario delle zone temperate di Europa, Asia e America.\nIl nome deriva dal latino primus per indicare la precocità di fioritura che avviene subito dopo la scomparsa della neve, quando nei prati comincia a comparire l'erba.\nComprende circa 500 specie di piante erbacee annuali e perenni, alte da pochi centimetri fino a diversi decimetri, con foglie basali a rosetta sessili o picciolate, fiori coloratissimi riuniti in ombrelle, capolini, grappoli o verticilli sovrapposti, circondati da brattee, sorretti da lunghi gambi. I frutti sono generalmente a capsula.",
      urlImage:
          'https://www.coltivazionebiologica.it/wp-content/uploads/2020/12/Primula.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Primula',
      classificationResults: ['primula'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Genziana',
      description:
          "Gentiana L. è un genere di piante della famiglia delle Gentianaceae, che comprende circa 400 specie.\nLe sue proprietà digestive sono portentose e note.\nSi tratta di piante annuali, biennali e perenni. Alcune sono sempreverdi, altre no. La disposizione delle foglie è opposta. Sono anche presenti foglie che formano una rosetta basale. I fiori sono a forma di imbuto; il colore è più comunemente azzurro o blu scuro, ma può variare dal bianco, avorio e dal giallo al rosso. Le specie col fiore di colore blu predominano nell'emisfero settentrionale, quelle col fiore rosso sulle Ande; le specie a fiore bianco sono più rare, ma più frequenti in Nuova Zelanda.",
      urlImage:
          'https://www.greenme.it/wp-content/uploads/2017/03/genziana_cover-1200x720.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Gentiana',
      classificationResults: ['gentiana'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Narciso',
      description:
          "Narcissus L. è un genere di piante della famiglia Amaryllidaceae ed è originario dell'Europa.\nIl genere si identifica, nell'ambito della famiglia, per la presenza di fiori isolati e apicali con paracorolla presente (gialla o rossa). Gli stami (6) sono inseriti al di sotto della paracorolla, non o poco sporgenti dal perigonio. Le foglie lineari-lanceolate sono basali, guainanti, con l'apice ottuso, di colore verde chiaro. Il bulbo è ovale-piriforme o a volte subgloboso, da cui origina lo scapo eretto e compresso, alto 20–50 cm. Il pistillo presenta un ovario infero. Il frutto è una capsula ovoidale.",
      urlImage:
          'https://www.tuttogreen.it/wp-content/uploads/2017/09/shutterstock_1521949868.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Narcissus',
      classificationResults: ['Narcissus pseudonarcissus'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Peonia',
      description:
          "Pæonia (Peonia L., 1753) è l'unico genere appartenente alla famiglia delle Peoniacee (Paeoniaceae (Raf., 1815)) ed costituito da diverse piante perenni a portamento erbaceo o arbustivo, molto apprezzate per le notevoli e profumate fioriture.\nLe peonie sono erbe o arbusti, alte fino a circa 2 metri ed ancorate al suolo da radici tuberose. Le foglie sono sempre caduche. I fiori sono grandi e molto colorati. Gli stami sono molto numerosi (in alcune specie possono essere più di 200). I frutti contengono semi scuri molto grossi (anche più di 1 cm di diametro).",
      urlImage:
          'https://res.cloudinary.com/greenplanner/images/f_auto,q_auto/v1590684838/peonia/peonia.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Paeonia',
      classificationResults: List.empty(),
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Ninfea',
      description:
          "Nymphaea L. 1753 è un genere di piante angiosperme appartenenti alla famiglia delle Ninfeacee dai fiori acquatici molto grandi e decorativi.\nSono piante acquatiche tipicamente radicanti e perenni. Alcune specie possono essere considerate palustri in quanto riescono a sopportare facilmente abbassamenti temporanei del livello dell'acqua. L'altezza media di queste piante dipende dalla profondità del bacino idrico e comunque superano raramente i due metri.",
      urlImage: 'https://www.giardinaggio.it/giardino/piante/ninfee_NG1.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Nymphaea',
      classificationResults: ['nymphaea'],
    ),
    Plant(
      discovered: false,
      discoveredTime: DateTime.fromMicrosecondsSinceEpoch(0),
      name: 'Melograno',
      description:
          "Il melograno (nome scientifico Punica granatum (L., 1753)) è una pianta appartenente alla famiglia delle Lythraceae (precedentemente in Punicaceae), originaria della regione compresa tra l'Iran e la catena himalayana, oltre presente sin dall'antichità nel Caucaso e nell'intera Macchia mediterranea. Il frutto viene chiamato melagrana ed è coltivato da molti millenni.\nL'unica altra specie appartenente a Punica è la Punica protopunica (Melograno di Socotra), endemica dell'isola di Socotra, (Oceano Indiano). Differisce per avere fiori rossi, o rosa, di minori dimensioni, e frutti meno dolci.",
      urlImage:
          'https://trea-agricoltura.it/wp-content/uploads/2020/12/melograno-da-fiore.jpg',
      urlWikipedia: 'https://it.wikipedia.org/wiki/Punica_granatum',
      classificationResults: ['Punica granatum'],
    )
  ];
}
