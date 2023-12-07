import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'katolika.db');
    ByteData data = await rootBundle.load(join('assets', 'katolika.db'));
    List<int> bytes = data.buffer.asUint8List();
    await File(path).writeAsBytes(bytes, flush: true);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS tBoky (id int PRIMARY KEY, boky varchar (40), testamenta varchar (40), toko int)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS tToko (id int primary key, boky int, toko int, fintina text)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS tAndininy (id int PRIMARY KEY, boky int, toko int, andininy int, votoatiny text)');
  }

  Future<List<Map<String, dynamic>>> getBoky(String? testamenta) async {
    final Database db = await database;

    if (testamenta != null) {
      // Lisitra isaky ny Testamenta
      return await db.rawQuery(
          'SELECT * FROM tBoky WHERE testamenta = "$testamenta" ORDER BY "id" ASC');
    } else {
      // Lisitry ny boky rehetra
      return await db.rawQuery('SELECT * FROM tBoky ORDER BY "id" ASC');
    }
  }

  //Lisitry ny toko
  Future<List<Map<String, dynamic>>> getToko(int bookId) async {
    final Database db = await database;
    return await db.query('tToko', where: 'boky = ?', whereArgs: [bookId]);
  }

  //Lisitry andininy
  Future<List<Map<String, dynamic>>> getAndiny(
      int bookId, int chapterNumber) async {
    final Database db = await database;
    return await db.query('tAndininy',
        where: 'boky = ? AND toko = ?', whereArgs: [bookId, chapterNumber]);
  }

  Future<int?> getBookId(String bookName) async {
    final Database db = await database;

    final result =
        await db.rawQuery('SELECT id FROM tBoky WHERE boky = ?', [bookName]);
    if (result.isNotEmpty) {
      return result[0]['id'] as int;
    } else {
      return null;
    }
  }

  Future<String> getBookTitle(int bookId) async {
    final Database db = await database;
    final books = await db.query('tBoky', where: 'id = ?', whereArgs: [bookId]);

    if (books.isEmpty) {
      return '';
    }

    return books[0]['boky'] as String;
  }

  Future<Map<String, dynamic>> getBookInfo(int bookId) async {
    final Database db = await database;

    final List<Map<String, dynamic>> result = await db.query(
      'tBoky',
      where: 'id = ?',
      whereArgs: [bookId],
      limit: 1,
    );

    return result.isNotEmpty ? result.first : {};
  }

  Future<String> getChapterFintina(int bookId, int chapterNumber) async {
    final Database db = await database;
    final chapter = await db.query('tToko',
        where: 'boky = ? AND toko = ?', whereArgs: [bookId, chapterNumber]);

    if (chapter.isEmpty) {
      return '';
    }

    return chapter[0]['fintina'] as String;
  }

  Future<List<Map<String, dynamic>>> getBooksGroupedByTestamenta() async {
    final Database db = await database;
    return await db
        .rawQuery('SELECT boky, testamenta FROM tBoky GROUP BY testamenta');
  }

  Future<int> countBooks(String testamenta) async {
    final Database db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) AS n FROM tBoky WHERE testamenta = ?',
      [testamenta],
    );
    final count = Sqflite.firstIntValue(result)!;
    return count;
  }

  Future<List<Map<String, dynamic>>> searchInTables(String searchTerm) async {
    final Database db = await database;

    // Recherche dans la table 'tBoky' avec jointure pour obtenir le nom du livre
    List<Map<String, dynamic>> bokyResults = await db.rawQuery(
      'SELECT tBoky.boky AS bookName, tBoky.id, tBoky.testamenta, tBoky.toko, tToko.fintina, tAndininy.andininy, tAndininy.votoatiny '
      'FROM tBoky '
      'INNER JOIN tToko ON tBoky.id = tToko.boky '
      'INNER JOIN tAndininy ON tBoky.id = tAndininy.boky '
      'WHERE tBoky.boky LIKE ? OR tToko.fintina LIKE ? OR tAndininy.votoatiny LIKE ? '
      'ORDER BY tBoky.id ASC LIMIT 30 OFFSET 0',
      ['%$searchTerm%', '%$searchTerm%', '%$searchTerm%'],
    );

    return bokyResults;
  }

  Future<List<Map<String, dynamic>>> getVersesInRange(
    int bookId, // Use the book's ID instead of the name
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
