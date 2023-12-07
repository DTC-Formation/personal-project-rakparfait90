import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';

class RecherchePage extends StatefulWidget {
  const RecherchePage({Key? key}) : super(key: key);

  @override
  State<RecherchePage> createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {
  // Contrôleur de la zone de texte de recherche
  final TextEditingController _searchController = TextEditingController();

  // Liste des résultats de la recherche
  List<Map<String, dynamic>> _searchResults = [];

  // Effectue la recherche de manière asynchrone
  void _performSearch() async {
    // Récupère le texte saisi dans la zone de texte de recherche
    String searchTerm = _searchController.text;

    // Appelle la fonction `searchInTables` de la classe `DatabaseHelper` pour effectuer la recherche
    _searchResults = await DatabaseHelper().searchInTables(searchTerm);

    // Met à jour l'état de la page de recherche
    setState(() {});
  }

  // Construit l'interface de la page de recherche
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitadiavana teny'),
      ),
      // Ajoute un `Column` pour organiser les éléments verticalement
      body: Column(
        children: [
          // Zone de recherche
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              // Indique que la zone de texte doit accepter du texte
              keyboardType: TextInputType.text,

              // Indique que l'action de recherche doit être déclenchée lorsque l'utilisateur appuie sur la touche Entrée
              textInputAction: TextInputAction.search,

              // Associe la zone de texte au contrôleur `_searchController`
              controller: _searchController,

              // Déclenche la fonction `_performSearch()` lorsque l'utilisateur soumet la valeur de la zone de texte
              onSubmitted: (value) {
                _performSearch();
              },

              // Définit la décoration de la zone de texte
              decoration: InputDecoration(
                // Texte affiché dans la zone de texte lorsqu'elle est vide
                hintText: 'Teny ho tadiavina...',

                // Ajoute une icône de recherche à droite de la zone de texte
                suffixIcon: IconButton(
                  // Définit l'icône de recherche
                  icon: const Icon(Icons.search),

                  // Déclenche la fonction `_performSearch` lorsque l'icône est pressée
                  onPressed: _performSearch,
                ),
              ),
            ),
          ),
          // Liste des résultats
          Expanded(
            child: ListView.builder(
              // Indique le nombre d'éléments dans la liste
              itemCount: _searchResults.length,

              // Définit la fonction qui construit chaque élément de la liste
              itemBuilder: (context, index) {
                // Récupère les informations nécessaires à partir de la recherche
                String bookName = _searchResults[index]['bookName'].toString();
                String chapterNumber = _searchResults[index]['toko'].toString();
                String verseNumber =
                    _searchResults[index]['andininy'].toString();
                String verseText =
                    _searchResults[index]['votoatiny'].toString();

                // Formate la chaîne pour l'affichage
                String resultString =
                    '$bookName $chapterNumber, $verseNumber: $verseText';

                List<TextSpan> spans = [];
                // Récupère la longueur du critère de recherche.
                int searchTermLength = _searchController.text.length;
                int start = resultString
                    .toLowerCase()
                    .indexOf(_searchController.text.toLowerCase());

                //vérifie si le critère de recherche est trouvé dans le résultat
                if (start == -1) {
                  spans.add(
                    const TextSpan(
                      text: 'Tsy nisy andininy hita',
                      style: TextStyle(color: primary),
                    ),
                  );
                } else {
                  spans.add(
                    TextSpan(
                      // Texte avant le critère de recherche
                      text: resultString.substring(0, start),
                      style: const TextStyle(
                        fontSize: 14,
                        // Couleur du texte avant le critère de recherche
                        color: primary,
                      ),
                    ),
                  );
                  // Texte du critère de recherche
                  spans.add(
                    TextSpan(
                      // Texte du critère de recherche
                      text: resultString.substring(
                          start, start + searchTermLength),
                      // // Met en surbrillance le critère de recherche
                      style: const TextStyle(
                        backgroundColor: Colors.yellow,
                        color: primary,
                      ),
                    ),
                  );

                  // Texte après le critère de recherche
                  spans.add(
                    TextSpan(
                      // Texte après le critère de recherche
                      text: resultString.substring(start + searchTermLength),
                      style: const TextStyle(
                        // Couleur du texte après le critère de recherche
                        color: primary,
                      ),
                    ),
                  );
                }

                // Retourne un `ListTile` avec le texte formaté
                return ListTile(
                  // Titre du `ListTile`
                  title: RichText(
                    // Texte du `ListTile`
                    text: TextSpan(
                      // Liste des `TextSpan`
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
