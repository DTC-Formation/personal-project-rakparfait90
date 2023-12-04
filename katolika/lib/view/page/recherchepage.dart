import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';

class RecherchePage extends StatefulWidget {
  const RecherchePage({Key? key}) : super(key: key);

  @override
  State<RecherchePage> createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  void _performSearch() async {
    String searchTerm = _searchController.text;
    _searchResults = await DatabaseHelper().searchInTables(searchTerm);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitadiavana teny'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Teny ho tadiavina...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _performSearch,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                // Récupérer les informations nécessaires depuis la recherche
                String bookName = _searchResults[index]['bookName'].toString();
                String chapterNumber = _searchResults[index]['toko'].toString();
                String verseNumber =
                    _searchResults[index]['andininy'].toString();
                String verseText =
                    _searchResults[index]['votoatiny'].toString();

                // Formater la chaîne pour l'affichage
                String resultString =
                    '$bookName $chapterNumber, $verseNumber: $verseText';

                // Mettre en surbrillance le critère de recherche
                List<TextSpan> spans = [];
                int searchTermLength = _searchController.text.length;
                int start = resultString
                    .toLowerCase()
                    .indexOf(_searchController.text.toLowerCase());
                if (start != -1) {
                  spans.add(
                    TextSpan(
                      text: resultString.substring(0, start),
                      style: const TextStyle(
                        fontSize: 14,
                        color: primary,
                      ),
                    ),
                  );
                  spans.add(
                    TextSpan(
                      text: resultString.substring(
                          start, start + searchTermLength),
                      style: const TextStyle(
                        backgroundColor:
                            Colors.yellow, // Couleur de surbrillance
                        fontSize: 14,
                        color: primary,
                      ),
                    ),
                  );
                  spans.add(
                    TextSpan(
                      text: resultString.substring(start + searchTermLength),
                      style: const TextStyle(
                        fontSize: 14,
                        color: primary,
                      ),
                    ),
                  );
                }

                return ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: spans,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
