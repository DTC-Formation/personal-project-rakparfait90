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
    String path = join(await getDatabasesPath(), 'baiboly.db');
    ByteData data = await rootBundle.load(join('assets', 'baiboly.db'));
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
      // Si testamenta est fourni, filtrer par testamenta
      return await db.rawQuery(
          'SELECT * FROM tBoky WHERE testamenta = "$testamenta" ORDER BY "id" ASC');
    } else {
      // Sinon, récupérer tous les livres
      return await db.query('tBoky');
    }
  }

  //Lisitry ny tokon'ilay boky
  Future<List<Map<String, dynamic>>> getChapters(int bookId) async {
    final Database db = await database;
    return await db.query('tToko', where: 'boky = ?', whereArgs: [bookId]);
  }

  //Lisitry andinin'ilay tokon'ilay boky
  Future<List<Map<String, dynamic>>> getVerses(
      int bookId, int chapterNumber) async {
    final Database db = await database;
    return await db.query('tAndininy',
        where: 'boky = ? AND toko = ?', whereArgs: [bookId, chapterNumber]);
  }

  Future<String> getBookTitle(int bookId) async {
    final Database db = await database;
    final books = await db.query('tBoky', where: 'id = ?', whereArgs: [bookId]);

    if (books.isEmpty) {
      return '';
    }

    return books[0]['boky'] as String;
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
}
