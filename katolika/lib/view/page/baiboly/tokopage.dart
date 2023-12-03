import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/baiboly/andininypage.dart';

class ChapterScreen extends StatelessWidget {
  final int bookId;

  const ChapterScreen({required this.bookId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealBlue,
        title: FutureBuilder<String>(
          future: DatabaseHelper().getBookTitle(bookId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text(
                snapshot.data!,
                style: const TextStyle(
                  color: Colors.white,
                ),
              );
            }
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Utilisez votre méthode pour récupérer la liste des chapitres en fonction du bookId
        future: DatabaseHelper().getChapters(bookId),
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
            // Récupérez la liste des chapitres depuis le snapshot
            final List<Map<String, dynamic>>? chapters = snapshot.data;

            // Vérifiez si chapters est null avant de l'utiliser
            if (chapters == null) {
              return const Center(
                child: Text('Tsy misy toko ity boky ity.'),
              );
            }

            // Affichage des chapitres sous forme de ListTile
            return ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final chapter = chapters[index];

                // Affichage du chapitre
                return ListTile(
                  leading: Text(
                    '${chapter['toko']}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.cyan,
                    ),
                  ),
                  title: Text(chapter['fintina']),
                  onTap: () {
                    // Naviguez vers la page VerseScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerseScreen(
                          bookId: bookId,
                          chapterNumber: chapter['toko'],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
