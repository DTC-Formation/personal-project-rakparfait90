import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';
import 'package:share_plus/share_plus.dart';

class RecherchePage extends StatefulWidget {
  const RecherchePage({super.key});

  @override
  State<RecherchePage> createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {
  TextEditingController controller = TextEditingController();
  DatabaseHelper db = DatabaseHelper();
  List<Map<String, dynamic>> results = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: fotsy,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: lighten_1),
          title: const Text(
            'Fitadiavana teny anaty Baiboly',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: manga,
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 18.0, bottom: 12.0),
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                controller: controller,
                onSubmitted: (value) => onSearch(),
                decoration: InputDecoration(
                  focusColor: manga,
                  labelText: 'Teny tadiavina',
                  floatingLabelStyle: const TextStyle(
                    fontSize: 18.0,
                    color: manga,
                    fontWeight: FontWeight.bold,
                  ),
                  labelStyle: const TextStyle(
                    color: manga,
                    fontSize: 18.0,
                  ),
                  hintText: 'Soraty ny teny ho tadiavina',
                  hintStyle: const TextStyle(color: manga),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: manga, width: 2.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: manga,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  filled: false,
                  // fillColor: lighten_2,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    color: manga,
                    onPressed: onSearch,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  var item = results.elementAt(index);
                  return Card(
                    margin: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                    color: mangaMatsora,
                    child: ListTile(
                      onTap: () => _showOptionsModal(context, item),
                      title: Text(
                        '${item['bokyName']} ${item['toko']}:${item['andininy']}',
                        style: const TextStyle(
                          color: manga,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${item['votoatiny']}',
                        style: const TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSearch() async {
    var searchText = controller.text;
    if (searchText.isNotEmpty) {
      var res = await db.searchSoratraMasina(searchText);
      setState(() {
        results = res;
        FocusScope.of(context).unfocus();
      });
    }
  }

  void _showOptionsModal(BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: fotsy,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(16.0),
              child: Text(
                '${item['bokyName']} ${item['toko']}:${item['andininy']}',
                style: const TextStyle(
                  color: manga,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              title: const Text('Tehirizina'),
              onTap: () async {
                // Ajouter l'élément aux favoris
                await db.addToFavorites(item);
                // Afficher une notification
                _showFavoriteAddedNotification(
                    '${item['bokyName']} ${item['toko']}:${item['andininy']}');
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                FocusScope.of(context).unfocus();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.share,
                color: Colors.grey,
              ),
              title: const Text('Zaraina...'),
              onTap: () {
                var content =
                    '${item['bokyName']} ${item['toko']}, ${item['andininy']} : ${item['votoatiny']}';
                Share.share(content);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    ).whenComplete(() => FocusScope.of(context).unfocus());
    FocusScope.of(context).unfocus();
  }

  void _showFavoriteAddedNotification(String smTehirizina) {
    final snackBar = SnackBar(
      margin: const EdgeInsets.all(8.0),
      backgroundColor: primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 0.0,
      behavior: SnackBarBehavior.floating,
      content: SizedBox(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.bookmark_added_rounded,
              color: Colors.green,
            ),
            const SizedBox(width: 10),
            const Text(
              'Voatahiry ny ',
              style: TextStyle(color: secondary),
            ),
            Text(
              smTehirizina,
              style: const TextStyle(
                color: secondary,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 4),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
