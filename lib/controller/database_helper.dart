import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    await db.execute(
        'CREATE TABLE IF NOT EXISTS tBoky (id INT, boky varchar (40), fanononaBoky varchar (255),testamenta VARCHAR (40),toko INT, PRIMARY KEY (id))');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS tToko (id int primary key, boky int, toko int, fintina text)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS tAndininy (id int PRIMARY KEY, boky int, toko int, andininy int, votoatiny text)');
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

  // Fonction pour obtenir la finition d'un chapitre
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

  // Future<List<Map<String, dynamic>>> getLohatenyByFihiranaId(
  //     int fihiranaId) async {
  //   final Database db = await database;
  //   final List<Map<String, dynamic>> result = await db.rawQuery(
  //     '''
  //   SELECT h.id, h.lohateny, h.tononkira, hf.pejy
  //   FROM hira h
  //   INNER JOIN hira_fihirana hf ON h.id = hf.hira_id
  //   WHERE hf.fihirana_id = ?
  //   ORDER BY hf.pejy ASC
  //   ''',
  //     [fihiranaId],
  //   );

  //   return result;
  // }

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
      // Filtre en fonction du "pejy" s'il est fourni
      result = await db.rawQuery(
        '''
      SELECT h.id, h.lohateny, h.tononkira, hf.pejy
      FROM hira h
      INNER JOIN hira_fihirana hf ON h.id = hf.hira_id
      WHERE hf.fihirana_id = ? AND hf.pejy = ?
      ORDER BY hf.pejy ASC
      ''',
        [fihiranaId, pejyFilter],
      );
    }

    return result;
  }
}
