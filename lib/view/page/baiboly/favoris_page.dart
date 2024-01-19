import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';
import 'package:share_plus/share_plus.dart';

class FavorisPage extends StatefulWidget {
  const FavorisPage({super.key});

  @override
  State<FavorisPage> createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
  DatabaseHelper db = DatabaseHelper();
  List<Map<String, dynamic>> favoris = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    var res = await db.getSMFavorites();
    setState(() {
      favoris = res;
    });
  }

  Future<void> _deleteSMFavorite(int id) async {
    await db.deleteSMFavorite(id);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: const IconThemeData(color: lighten_1),
        title: const Text(
          'Andininy voatahiry',
          style: TextStyle(
            color: lighten_1,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: favoris.length,
        itemBuilder: (context, index) {
          var item = favoris.elementAt(index);
          return Card(
            margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
            color: secondary,
            child: ListTile(
              title: Text(
                '${item['bokyName']} ${item['toko']}:${item['andininy']}',
                style: const TextStyle(
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.share,
                        color: Colors.grey), // Icone de partage
                    onPressed: () {
                      //Ici, mettez la logique que vous souhaitez exécuter lorsque l'icône de partage est appuyée
                      var content =
                          '${item['bokyName']} ${item['toko']}:${item['andininy']} - ${item['votoatiny']}';
                      Share.share(content);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      // Appeler la méthode pour supprimer le favori sélectionné
                      _deleteSMFavorite(item['id']);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
