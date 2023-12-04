import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';

class VerseScreen extends StatelessWidget {
  final int bookId;
  final int chapterNumber;

  const VerseScreen({
    required this.bookId,
    required this.chapterNumber,
    Key? key,
  }) : super(key: key);

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
                '${snapshot.data!} : $chapterNumber',
                style: const TextStyle(
                  color: Colors.white,
                ),
              );
            }
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Utilisez votre méthode pour récupérer la liste des versets en fonction du bookId et du chapterNumber
        future: DatabaseHelper().getVerses(bookId, chapterNumber),
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
            // Récupérez la liste des versets depuis le snapshot
            List<Map<String, dynamic>> verses = snapshot.data!;

            //Concaténer les versets dans une seule chaîne
            String allVersesText = verses
                .map((verse) => "${verse['andininy']} ${verse['votoatiny']}")
                .join(" ");

            // Affichage fintina an'ilay toko dans une carte
            return Column(
              children: [
                FutureBuilder<String>(
                  future:
                      DatabaseHelper().getChapterFintina(bookId, chapterNumber),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          snapshot.data!,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                // Utiliser un ListView.builder pour afficher tous les versets avec un saut de ligne entre chaque
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        text: '$allVersesText ',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
