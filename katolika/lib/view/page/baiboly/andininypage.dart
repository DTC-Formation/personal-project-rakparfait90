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
        future: DatabaseHelper().getAndiny(bookId, chapterNumber),
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

            // Concaténer les versets dans une seule chaîne
            Padding allVersesText = Padding(
              padding: const EdgeInsets.all(6.0),
              child: SingleChildScrollView(
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: const TextStyle(height: 1.7),
                    children: verses.map((verse) {
                      return TextSpan(
                        children: [
                          // Utiliser une taille de police plus petite pour simuler l'exposant
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(0,
                                  -5), // Ajustez cet offset pour simuler l'exposant
                              child: Text(
                                '${verse['andininy']}', // Remplacez par le texte de l'exposant
                                style: const TextStyle(
                                  fontSize:
                                      14, // Ajustez la taille de la police pour simuler l'exposant
                                  color: Colors
                                      .red, // Vous pouvez ajuster la couleur si nécessaire
                                ),
                              ),
                            ),
                          ),
                          TextSpan(
                            text: ' ${verse['votoatiny']} ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );

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
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          snapshot.data!,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      );
                    }
                  },
                ),
                // afficher tous les versets avec un saut de ligne entre chaque
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: allVersesText,
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
