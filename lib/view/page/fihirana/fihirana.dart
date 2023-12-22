import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/fihirana/lisitrafihirana.dart';

class FihiranaKatolika extends StatelessWidget {
  const FihiranaKatolika({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 60.0),
            child: Text(
              "Fihirana Katolika",
              style: TextStyle(
                color: secondary,
                fontSize: 52,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Lisitry ny fihirana
          Card(
            margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
            color: primary,
            child: ListTile(
              contentPadding: const EdgeInsets.all(2),
              leading:
                  Image.asset('assets/images/icons/famakiana.png', height: 48),
              title: const Text(
                "Lisitry ny fihirana",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                "Ahitana ny lisitry ny fihirana voatahiry sy mijery ny fanoroam-pejy",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        FadeTransition(
                      opacity: animation,
                      child:
                          const LisitraFihirana(),
                    ),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
            ),
          ),
          //Fitadiavana
          Card(
            margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
            color: primary,
            child: ListTile(
              contentPadding: const EdgeInsets.all(2),
              leading: Image.asset('assets/images/icons/fitadiavana.png',
                  height: 48),
              title: const Text(
                "Fitadiavana hira",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                "Fitadiavana hira araky ny lohateny",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              onTap: () {
                // Naviguer vers la page de recherche
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const RecherchePage()),
                // );
              },
            ),
          ),
          //Salamo
          Card(
            margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
            color: primary,
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(6, 2, 2, 2),
              leading: const Icon(
                Icons.library_books_outlined,
                size: 42,
                color: Colors.white,
              ),
              title: const Text(
                "Salamo",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                "Lisitry ny Salamo araky ny filaharany",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/fanitsiana');
              },
            ),
          ),
          //Hira rehetra
          Card(
            margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
            color: primary,
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(6, 2, 2, 2),
              leading: const Icon(
                Icons.library_music_outlined,
                size: 42,
                color: Colors.white,
              ),
              title: const Text(
                "Sokajy rehetra",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                "Lisitry ny hira araky ny sokajiny ampiasaina amin'ny litorjia",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/fanitsiana');
              },
            ),
          ),
          //Favoris
          Card(
            margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
            color: primary,
            child: ListTile(
              contentPadding: const EdgeInsets.all(2),
              leading:
                  Image.asset('assets/images/icons/voatahiry.png', height: 48),
              title: const Text(
                "Ireo hira notehirizinao",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                "Lisitry ny hira notehirizinao mba ho mora hiverenana amin'ny manaraka",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/voatahiry');
              },
            ),
          ),
          //Sokajy rehetra

          //Ireo hira notehirizinao
          Card(
            margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
            color: primary,
            child: ListTile(
              contentPadding: const EdgeInsets.all(2),
              leading:
                  Image.asset('assets/images/icons/fanitsiana.png', height: 48),
              title: const Text(
                "Fanitsiana",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                "Fakana ny fanintsiana farany raha toa ka misy nahitsy na nisy hira vaovao nampidirina",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/fanitsiana');
              },
            ),
          ),
        ],
      ),
    );
  }
}
