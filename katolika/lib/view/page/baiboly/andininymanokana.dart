import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';

class AndininyManokana extends StatelessWidget {
  final String bookName;
  final String bookTitle;
  final int toko;
  final int startAndininy;
  final int endAndininy;

  const AndininyManokana({
    super.key,
    required this.bookName,
    required this.bookTitle,
    required this.toko,
    required this.startAndininy,
    required this.endAndininy,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$bookName $toko, $startAndininy - $endAndininy'),
      ),
      body: FutureBuilder<String>(
        future: _fetchBookAndChapterInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Column(
              children: [
                _buildVersesListView(),
              ],
            );
          }
        },
      ),
    );
  }

  Future<String> _fetchBookAndChapterInfo() async {
    final int bookId = await DatabaseHelper().getBokyId(bookName) ?? 0;
    final Map<String, dynamic> bookInfo =
        await DatabaseHelper().getBokyInfo(bookId);

    final String bookTitle = bookInfo['boky'] ?? '';
    final String testamenta = bookInfo['testamenta'] ?? '';

    final String chapterFintina =
        await DatabaseHelper().getTokoFintina(bookId, toko);

    return '$bookTitle $testamenta $toko: $chapterFintina $startAndininy - $endAndininy';
  }

  Widget _buildVersesListView() {
    return FutureBuilder<List<TextSpan>>(
      future: _fetchVerses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<TextSpan> verses = snapshot.data ?? [];

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: const TextStyle(height: 1.7),
                    children: verses,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<TextSpan>> _fetchVerses() async {
    final int bookId = await DatabaseHelper().getBokyId(bookName) ?? 0;
    final List<Map<String, dynamic>> versesData =
        await DatabaseHelper().getAndininyhatriminy(
      bookId,
      toko,
      startAndininy,
      endAndininy,
    );

    return versesData.map((verse) {
      final andininy = verse['andininy'].toString();
      final votoatiny = verse['votoatiny'].toString();

      return TextSpan(
        children: [
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(0, -5),
              child: Text(
                ' $andininy ',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          TextSpan(
            text: ' $votoatiny',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      );
    }).toList();
  }
}
