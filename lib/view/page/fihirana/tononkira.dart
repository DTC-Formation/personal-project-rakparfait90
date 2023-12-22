import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/fihirana/header.dart';

class TononkiraScreen extends StatefulWidget {
  final int hiraId;
  final String hiraLohateny;
  final String tononkira;

  const TononkiraScreen({
    required this.hiraId,
    required this.hiraLohateny,
    required this.tononkira,
    super.key,
  });

  @override
  State<TononkiraScreen> createState() => _TononkiraScreenState();
}

class _TononkiraScreenState extends State<TononkiraScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // Stocker le contenu initial de tononkira.
    String tononkira = widget.tononkira;

// Définir l'expression régulière pour les mots en gras.
    RegExp regExp = RegExp(r'\*([^\*]*)\*');

// Trouver toutes les occurrences de mots en gras.
    List<Match> matches = regExp.allMatches(tononkira).toList();

// Remplacer les mots en gras par des marqueurs pour faciliter le traitement.
// Définir la variable match à l'extérieur de la boucle.
    for (Match match in matches) {
      tononkira = tononkira.replaceAll(match.group(0)!, match.group(1) ?? '');
    }

// Diviser le texte en une liste de mots séparés par les marqueurs.
    List<String> mots = tononkira.split('_');

// Créer un objet TextSpan pour chaque mot.
    List<TextSpan> textSpans = mots.map((mot) {
      Match? match;
      if (matches.any((match) => match.group(1) == mot)) {
        match = matches.firstWhere((match) => match.group(1) == mot);
      }

      if (match != null) {
        String motGras = match.group(1) ?? '';
        return TextSpan(
          text: motGras,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: primary,
          ),
        );
      } else {
        return TextSpan(
          text: mot,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: primary,
          ),
        );
      }
    }).toList();

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: const HeaderFihirana(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // container pour lohateny
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.hiraLohateny,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // container pour pejy fihirana
          FutureBuilder<List<Map<String, dynamic>>>(
            future: DatabaseHelper().getHiraInfo(widget.hiraId),
            builder: (context, pejySnapshot) {
              if (pejySnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (pejySnapshot.hasError) {
                return Center(
                  child: Text('Misy olana: ${pejySnapshot.error}'),
                );
              } else {
                List<Map<String, dynamic>> pejyList = pejySnapshot.data ?? [];
                return Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: pejyList.length,
                    itemExtent: 15.0,
                    padding: const EdgeInsets.only(bottom: 32.0),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final pejy = pejyList.elementAt(index)['pejy'] as int;
                      final fihirana =
                          pejyList.elementAt(index)['fihirana'] as String;

                      return ListTile(
                        title: Text(
                          "$fihirana - p. $pejy",
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),

          // container pour tononkira
          Expanded(
            child: Container(
              width: size.width,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child:
                  // Encapsuler tous les `TextSpan` dans un `RichText`
                  SingleChildScrollView(
                child: RichText(
                  text: TextSpan(
                    children: textSpans,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
