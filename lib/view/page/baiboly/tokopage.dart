import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/baiboly/andininypage.dart';

class ChapterScreen extends StatelessWidget {
  final int bookId;
  final String bookFanononana;

  const ChapterScreen({
    required this.bookId,
    required this.bookFanononana,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: secondary,
        title: FutureBuilder<String>(
          future: DatabaseHelper().getBokyName(bookId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text(
                '${snapshot.data!} ',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                ),
              );
            }
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Utilisez votre méthode pour récupérer la liste des chapitres en fonction du bookId
        future: DatabaseHelper().getToko(bookId),
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
            List<Map<String, dynamic>> chapters = snapshot.data!;

            // Concaténer les versets dans une seule chaîne
            Padding allToko = Padding(
              padding: const EdgeInsets.all(1.0),
              child: ListView.builder(
                itemCount: chapters.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                    color: Colors.blue[100],
                    elevation: 1.0,
                    child: ListTile(
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "Toko ${chapters.elementAt(index)['toko']}",
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(
                                text:
                                    " ${chapters.elementAt(index)['fintina']}",
                                style: const TextStyle(color: primary))
                          ],
                        ),
                      ),
                      onTap: () {
                        // Naviguez vers la page VerseScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerseScreen(
                              bookId: bookId,
                              chapterNumber: chapters.elementAt(index)['toko'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );

            // Affichage fintina an'ilay toko dans une carte
            return Column(
              children: [
                FutureBuilder<String>(
                  future: DatabaseHelper().getBokyTitle(bookId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Container(
                        color: secondary,
                        alignment: Alignment.center,
                        width: size.width,
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: Text(
                          " ${snapshot.data!}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  },
                ),
                // afficher tous les versets avec un saut de ligne entre chaque
                Expanded(
                  child: allToko,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
