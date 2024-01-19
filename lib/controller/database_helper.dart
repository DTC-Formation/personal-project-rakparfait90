import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  static Database? _database;

  // Fonction pour obtenir la base de données
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Fonction d'initialisation de la base de données
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'katolika.db');
    ByteData data = await rootBundle.load(join('assets', 'katolika.db'));
    List<int> bytes = data.buffer.asUint8List();
    await File(path).writeAsBytes(bytes, flush: true);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Fonction d'exécution lors de la création de la base de données
  Future<void> _onCreate(Database db, int version) async {
    //table pour baiboly
    await db.execute(
        'CREATE TABLE IF NOT EXISTS tBoky (id INT, boky varchar (40), fanononaBoky varchar (255),testamenta VARCHAR (40),toko INT, PRIMARY KEY (id))');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS tToko (id int primary key, boky int, toko int, fintina text)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS tAndininy (id int PRIMARY KEY, boky int, toko int, andininy int, votoatiny text)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS smFavorites (id INTEGER PRIMARY KEY AUTOINCREMENT,bokyName TEXT, toko TEXT, andininy INTEGER, votoatiny TEXT)');
    // table pour Fihirana
    await db.execute(
        'CREATE TABLE IF NOT EXISTS fihirana (id INT, fihirana TEXT, fihirana_subtitle TEXT, created_at NUM, updated_at  NUM)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS hira_fihirana (id INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT, hira_id INTEGER  NOT NULL, fihirana_id INTEGER  NOT NULL, pejy INTEGER  NOT NULL, created_at  DATETIME, updated_at  DATETIME, FOREIGN KEY (hira_id) REFERENCES hira (id) ON DELETE CASCADE, FOREIGN KEY (fihirana_id) REFERENCES fihirana (id) ON DELETE CASCADE)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS hira ( id INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT, lohateny VARCHAR  NOT NULL, tononkira  TEXT     NOT NULL, created_at DATETIME, updated_at DATETIME)');
    await db.execute(
        "CREATE TABLE IF NOT EXISTS salamo (id INT (11) NOT NULL, hira_id INT (11) NOT NULL DEFAULT '0', faha INT (11) NOT NULL DEFAULT '0', PRIMARY KEY (id))");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS sokajy (id INT (11) NOT NULL, sokajy VARCHAR (100) DEFAULT NULL, sokajy_description VARCHAR (255) DEFAULT NULL, PRIMARY KEY (id))");
    //table pour la missel
    await db.execute(
        "CREATE TABLE IF NOT EXISTS smi (id INTEGER PRIMARY KEY AUTOINCREMENT, daty DATE, daty_gasy VARCHAR (100), herinandro VARCHAR (100), vanimpotoana VARCHAR (100), num_taona VARCHAR (100), type_taona VARCHAR (100), vkt1 VARCHAR (100), vkt1_soratra TEXT, salamo VARCHAR (100), salamo_soratra TEXT, vkt2 VARCHAR (100), vkt2_soratra TEXT, evanjely VARCHAR (100), evanjely_soratra TEXT, olomasina VARCHAR (300))");
  }

  // Fonction pour compter le nombre de livres dans un testamenta
  Future<int> countBooks(String testamenta) async {
    final Database db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) AS n FROM tBoky WHERE testamenta = ?',
      [testamenta],
    );
    final count = Sqflite.firstIntValue(result)!;
    return count;
  }

  // Fonction pour obtenir la liste des livres en fonction du testament
  Future<List<Map<String, dynamic>>> getBoky(String? testamenta) async {
    final Database db = await database;

    if (testamenta != null) {
      return await db.rawQuery(
          'SELECT * FROM tBoky WHERE testamenta = "$testamenta" ORDER BY "id" ASC');
    } else {
      return await db.rawQuery('SELECT * FROM tBoky ORDER BY "id" ASC');
    }
  }

  // Fonction pour obtenir le titre d'un livre en fonction de son ID
  Future<String> getBokyTitle(int bookId) async {
    final Database db = await database;
    final books = await db.query('tBoky', where: 'id = ?', whereArgs: [bookId]);

    if (books.isEmpty) {
      return '';
    }

    return books.elementAt(0)['fanononanaBoky'] as String;
  }

  // Fonction pour obtenir le titre d'un livre en fonction de son ID
  Future<String> getBokyName(int bookId) async {
    final Database db = await database;
    final books = await db.query('tBoky', where: 'id = ?', whereArgs: [bookId]);

    if (books.isEmpty) {
      return '';
    }

    return books.elementAt(0)['boky'] as String;
  }

  // Fonction pour obtenir la liste des chapitres d'un livre
  Future<List<Map<String, dynamic>>> getToko(int bookId) async {
    final Database db = await database;
    return await db.rawQuery('SELECT * FROM tToko WHERE boky = ?', [bookId]);
  }

  // Fonction pour obtenir la liste des versets d'un chapitre
  Future<List<Map<String, dynamic>>> getAndiny(
      int bookId, int chapterNumber) async {
    final Database db = await database;
    return await db.query('tAndininy',
        where: 'boky = ? AND toko = ?', whereArgs: [bookId, chapterNumber]);
  }

  // Fonction pour obtenir l'ID d'un livre en fonction de son nom
  Future<int?> getBokyId(String bookName) async {
    final Database db = await database;

    final result =
        await db.rawQuery('SELECT id FROM tBoky WHERE boky = ?', [bookName]);
    if (result.isNotEmpty) {
      return result.elementAt(0)['id'] as int;
    } else {
      return null;
    }
  }

  // Fonction pour obtenir les informations d'un livre en fonction de son ID
  Future<Map<String, dynamic>> getBokyInfo(int bookId) async {
    final Database db = await database;

    final List<Map<String, dynamic>> result = await db.query(
      'tBoky',
      where: 'id = ?',
      whereArgs: [bookId],
      limit: 1,
    );

    return result.isNotEmpty ? result.first : {};
  }

  // Fonction pour obtenir la fintina d'un chapitre
  Future<String> getTokoFintina(int bookId, int chapterNumber) async {
    final Database db = await database;
    final chapter = await db.query('tToko',
        where: 'boky = ? AND toko = ?', whereArgs: [bookId, chapterNumber]);

    if (chapter.isEmpty) {
      return '';
    }

    return chapter.elementAt(0)['fintina'] as String;
  }

  // Fonction pour obtenir une liste de versets dans une plage spécifiée
  Future<List<Map<String, dynamic>>> getAndininyhatriminy(
    int bookId, // Utiliser l'ID du livre au lieu du nom
    int toko,
    int startAndininy,
    int endAndininy,
  ) async {
    final Database db = await database;

    return await db.rawQuery(
      'SELECT * FROM tAndininy WHERE boky = ? AND toko = ? AND andininy BETWEEN ? AND ? ORDER BY andininy ASC',
      [bookId, toko, startAndininy, endAndininy],
    );
  }

  //Fitaviana teny anaty baiboly
  Future<List<Map<String, dynamic>>> searchSoratraMasina(
      String searchText) async {
    final Database db = await database;
    // Effectuer la jointure entre les tables tAndininy et tBoky
    const String query = """
    SELECT 
      b.boky AS bokyName, 
      a.toko, 
      a.andininy, 
      a.votoatiny 
    FROM 
      tAndininy AS a 
      INNER JOIN tBoky AS b 
      ON a.boky = b.id 
    WHERE 
      a.votoatiny LIKE ?
    """;

    List<Map<String, dynamic>> results = await db.rawQuery(
      query,
      ['%$searchText%'],
    );

    return results;
  }

  // ajout aux Favoris
  Future<int> addToFavorites(Map<String, dynamic> item) async {
    final db = await database;
    return await db.insert('smFavorites', item);
  }

  // Afficher les Favoris
  Future<List<Map<String, dynamic>>> getSMFavorites() async {
    final db = await database;
    return await db.query('smFavorites');
  }

  //Supprimer un Favoris
  Future<void> deleteSMFavorite(int id) async {
    final db = await database;
    await db.delete('smFavorites', where: 'id = ?', whereArgs: [id]);
  }

  // Fonction pour obtenir la liste des fihirana
  Future<List<Map<String, dynamic>>> getFihirana(String? fihiranaId) async {
    final Database db = await database;

    if (fihiranaId != null) {
      return await db.rawQuery(
          'SELECT * FROM fihirana WHERE id = ? ORDER BY fihirana ASC',
          [fihiranaId]);
    } else {
      return await db
          .rawQuery('SELECT * FROM fihirana ORDER BY "fihirana" ASC');
    }
  }

  // Fonction pour compter le nombre des chansons par FIhirana
  Future<int> countHira(String fihirana) async {
    final Database db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) AS n FROM hira_fihirana WHERE fihirana_id = ?',
      [fihirana],
    );
    final count = Sqflite.firstIntValue(result)!;
    return count;
  }

  // Fonction pour obtenir la page (pejy) d'une chanson dans tous les Fihirana
  Future<List<Map<String, dynamic>>> getHiraInfo(int hiraId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      """
    SELECT
      f.fihirana,
      hf.pejy
    FROM hira_fihirana hf
    INNER JOIN hira h ON hf.hira_id = h.id
    INNER JOIN fihirana f ON hf.fihirana_id = f.id
    WHERE hf.hira_id = ?
    ORDER BY hf.pejy ASC
    """,
      [hiraId],
    );

    return result;
  }

  Future<List<Map<String, dynamic>>> getLohatenyByFihiranaId(
    int fihiranaId, {
    int? pejy,
  }) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result;
    final pejyFilter = pejy?.toString();

    if (pejy == null) {
      // Récupère toutes les lohateny sans filtrage
      result = await db.rawQuery(
        '''
      SELECT h.id, h.lohateny, h.tononkira, hf.pejy
      FROM hira h
      INNER JOIN hira_fihirana hf ON h.id = hf.hira_id
      WHERE hf.fihirana_id = ?
      ORDER BY hf.pejy ASC
      ''',
        [fihiranaId],
      );
    } else {
      // Filtre en fonction du "pejy" s'elle est fournie
      result = await db.rawQuery(
        '''
      SELECT h.id, h.lohateny, h.tononkira, hf.pejy
      FROM hira h
      INNER JOIN hira_fihirana hf ON h.id = hf.hira_id
      WHERE hf.fihirana_id = ? AND hf.pejy LIKE ?
      ORDER BY hf.pejy ASC
      ''',
        [fihiranaId, '%$pejyFilter%'],
      );
    }

    return result;
  }

  //Liste Salamo
  Future<List<Map<String, dynamic>>> getSalamo({
    int? salamoFaha,
  }) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result;
    final pejyFilter = salamoFaha?.toString();
    if (salamoFaha == null) {
      result = await db.rawQuery(
        '''
      SELECT h.id, h.lohateny, h.tononkira, f.fihirana, hf.pejy, s.faha
      FROM hira h
      INNER JOIN hira_fihirana hf ON h.id = hf.hira_id
      INNER JOIN fihirana f ON hf.fihirana_id = f.id
      INNER JOIN salamo s ON h.id = s.hira_id
      GROUP BY h.lohateny
      ORDER BY s.faha ASC
      ''',
      );
    } else {
      result = await db.rawQuery(
        '''
      SELECT h.id, h.lohateny, h.tononkira, f.fihirana, hf.pejy, s.faha
      FROM hira h
      INNER JOIN hira_fihirana hf ON h.id = hf.hira_id
      INNER JOIN fihirana f ON hf.fihirana_id = f.id
      INNER JOIN salamo s ON h.id = s.hira_id
      WHERE s.faha = ?
      GROUP BY h.lohateny
      ORDER BY s.faha ASC
      ''',
        [pejyFilter],
      );
    }

    return result;
  }

  // fonction pour afficher Sorona Masina androany
  Future<List<Map<String, dynamic>>> getEvanjelyAnio() async {
    final Database db = await database;
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    List<Map<String, dynamic>> results = await db.query(
      'smi',
      where: 'daty = ?',
      whereArgs: [todayDate],
    );

    return results;
  }

  // fonction pour afficher Missel

  Future<List<Map<String, dynamic>>> getSoronaMasina(
      {required int page, int limit = 30}) async {
    final Database db = await database;
    int offset = (page - 1) * limit;

    List<Map<String, dynamic>> results = await db.query(
      'smi',
      where: 'daty >= ?',
      whereArgs: ['2024-01-01'],
      limit: limit,
      offset: offset,
      orderBy: 'daty ASC',
    );

    return results;
  }

  // Future<List<Map<String, dynamic>>> getSoronaMasinaByDate(String date,
  //     {required int page, int limit = 30}) async {
  //   final Database db = await database;
  //   int offset = (page - 1) * limit;

  //   List<Map<String, dynamic>> results = await db.query(
  //     'smi',
  //     where: 'daty >= ?',
  //     whereArgs: [date],
  //     limit: limit,
  //     offset: offset,
  //   );

  //   return results;
  // }

  // Future<int> getIndexByDate(String date) async {
  //   final db = await database;
  //   try {
  //     int count = Sqflite.firstIntValue(await db
  //             .rawQuery('SELECT COUNT(*) FROM smi WHERE daty < ?', [date])) ??
  //         0;
  //     print(count);
  //     return count;
  //   } catch (e) {
  //     print('Erreur lors de la récupération de l\'index pour la date: $e');
  //     return -1;
  //   }
  // }

  // Future<List<Map<String, dynamic>>> getSoronaMasinaBeforeDate(String date,
  //     {int limit = 30}) async {
  //   final Database db = await database;

  //   List<Map<String, dynamic>> results = await db.query(
  //     'smi',
  //     where: 'daty < ?',
  //     whereArgs: [date],
  //     limit: limit,
  //     orderBy: 'daty DESC',
  //   );

  //   return results;
  // }

  // Future<List<Map<String, dynamic>>> getSoronaMasinaAfterDate(String date,
  //     {int limit = 30}) async {
  //   final Database db = await database;

  //   List<Map<String, dynamic>> results = await db.query(
  //     'smi',
  //     where: 'daty > ?',
  //     whereArgs: [date],
  //     limit: limit,
  //     orderBy: 'daty ASC',
  //   );

  //   return results;
  // }

  // fonction pour Olomasina
  Future<List<Map<String, dynamic>>> getOlomasina() async {
    final Database db = await database;
    String todayDate = DateFormat('MM-dd').format(DateTime.now());

    List<Map<String, dynamic>> results = await db.query(
      'olomasina',
      where: 'daty = ?',
      whereArgs: [todayDate],
    );

    return results;
  }
}
