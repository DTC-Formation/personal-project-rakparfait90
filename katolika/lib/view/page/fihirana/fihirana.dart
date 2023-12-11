import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';

class FihiranaKatolika extends StatelessWidget {
  const FihiranaKatolika({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 40.0, bottom: 60.0),
          child: Text(
            "Fihirana Katolika",
            style: TextStyle(
              color: tealBlue,
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
              Navigator.pushNamed(context, '/flisitra');
            },
          ),
        ),
        //Fitadiavana
        Card(
          margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
          color: primary,
          child: ListTile(
            contentPadding: const EdgeInsets.all(2),
            leading:
                Image.asset('assets/images/icons/fitadiavana.png', height: 48),
            title: const Text(
              "Fitadiavana teny",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              "Hitady teny amin’ny boky iray na boky manontolo",
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
            contentPadding: const EdgeInsets.all(2),
            leading:
                Image.asset('assets/images/icons/voatahiry.png', height: 48),
            title: const Text(
              "Andininy voatahiry",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              "Ireo andininy notehirizinao",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/voatahiry');
            },
          ),
        ),
        //Sokajy rehetra
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
              "Fakana ny fanintsiana farany raha toa ka misy nahitsy",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/fanitsiana');
            },
          ),
        ),
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
              "Fakana ny fanintsiana farany raha toa ka misy nahitsy",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/fanitsiana');
            },
          ),
        ),
      ],
    );
  }
}
