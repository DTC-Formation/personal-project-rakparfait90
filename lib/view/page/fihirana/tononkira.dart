import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';

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
  double _textScale = 1.0;
  var _zoomColorM = Colors.red.shade300;
  var _zoomColorP = manga;

  void _onTextScaleChanged(double value, var colorState) {
    setState(() {
      _textScale = value;
      _zoomColorM = colorState;
      _zoomColorP = colorState;
      if (_textScale <= 1.0) {
        _textScale = 1.0;
        _zoomColorM = Colors.red.shade300;
      } else if (_textScale >= 3.0) {
        _textScale = 3.0;
        _zoomColorP = Colors.red.shade300;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String tononkira = widget.tononkira;

    // Définir l'expression régulière pour les mots en gras.
    RegExp regExp = RegExp(r'\*([^\*]*)\*');

    // Trouver toutes les occurrences de mots en gras.
    List<Match> matches = regExp.allMatches(tononkira).toList();

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
          ),
        );
      } else {
        return TextSpan(
          text: mot,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        );
      }
    }).toList();

    return Scaffold(
      backgroundColor: lighten_2,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset('assets/images/icons/fihirana_w.png', height: 28),
        ),
        backgroundColor: manga,
        title: const Text(
          'Fihirana Katolika',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
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
                color: manga,
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
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: pejyList.length,
                    itemExtent: 20.0,
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
                            color: mena,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
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
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
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
              child: SingleChildScrollView(
                child: LayoutBuilder(builder: (context, constraints) {
                  return SelectableText.rich(
                    TextSpan(
                      children: textSpans,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    textScaler: TextScaler.linear(_textScale),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              highlightElevation: 0.0,
              mini: true,
              backgroundColor: _zoomColorM,
              onPressed: () {
                _onTextScaleChanged(_textScale - 0.2, manga);
              },
              child: const Icon(
                Icons.zoom_out,
                color: fotsy,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            FloatingActionButton(
              highlightElevation: 0.0,
              mini: true,
              backgroundColor: _zoomColorP,
              onPressed: () {
                _onTextScaleChanged(_textScale + 0.2, manga);
              },
              heroTag: "zoom",
              child: const Icon(
                Icons.zoom_in,
                color: fotsy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
