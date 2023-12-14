// Fonction pour rechercher dans les tables
  // Future<List<Map<String, dynamic>>> searchInTables(
  //     String searchTerm, String s) async {
  //   final Database db = await database;

  //   List<Map<String, dynamic>> bokyResults = await db.rawQuery(
  //     'SELECT DISTINCT tBoky.boky AS bookName, tBoky.id, tBoky.testamenta, tBoky.toko '
  //     'FROM tBoky '
  //     'WHERE LOWER(tBoky.boky) LIKE ? OR LOWER(tBoky.testamenta) LIKE ?',
  //     ['%$searchTerm%', '%$searchTerm%'],
  //   );

  //   print("Boky Results: $bokyResults");

  //   List<Map<String, dynamic>> tokoResults = await db.rawQuery(
  //     'SELECT DISTINCT tToko.boky AS bookId, tToko.toko, tToko.fintina '
  //     'FROM tToko '
  //     'WHERE LOWER(tToko.fintina) LIKE ?',
  //     ['%$searchTerm%'],
  //   );

  //   print("Toko Results: $tokoResults");

  //   List<Map<String, dynamic>> andininyResults = await db.rawQuery(
  //     'SELECT DISTINCT tAndininy.boky AS bookId, tAndininy.toko, tAndininy.andininy, tAndininy.votoatiny '
  //     'FROM tAndininy '
  //     'WHERE LOWER(tAndininy.votoatiny) LIKE ?',
  //     ['%$searchTerm%'],
  //   );

  //   print("Andininy Results: $andininyResults");

  //   List<Map<String, dynamic>> mergedResults = [];
  //   for (var bokyResult in bokyResults) {
  //     int bookId = bokyResult['id'];

  //     // Recherche des résultats dans tToko
  //     var tokoResultsForBook =
  //         tokoResults.where((toko) => toko['bookId'] == bookId).toList();

  //     // Recherche des résultats dans tAndininy
  //     var andininyResultsForBook = andininyResults
  //         .where((andininy) => andininy['bookId'] == bookId)
  //         .toList();

  //     // Fusion des résultats
  //     for (var i = 0; i < tokoResultsForBook.length; i++) {
  //       mergedResults.add({
  //         'bookName': bokyResult['bookName'],
  //         'toko': tokoResultsForBook.elementAt(i)['toko'],
  //         'andininy': andininyResultsForBook.elementAt(i)['andininy'],
  //         'votoatiny': andininyResultsForBook.elementAt(i)['votoatiny'],
  //       });
  //     }
  //   }

  //   print("Merged Results: $mergedResults");

  //   return mergedResults;
  // }