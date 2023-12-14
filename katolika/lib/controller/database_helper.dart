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

  // Fonction pour obtenir la liste des livres groupés par testamenta
  Future<List<Map<String, dynamic>>> getBooksGroupedByTestamenta() async {
    final Database db = await database;
    return await db
        .rawQuery('SELECT * boky testamenta FROM tBoky GROUP BY testamenta');
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
    return await db.query('tToko', where: 'boky = ?', whereArgs: [bookId]);
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
}
