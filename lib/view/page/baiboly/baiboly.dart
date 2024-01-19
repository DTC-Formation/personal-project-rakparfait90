import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/baiboly/favoris_page.dart';
import 'package:katolika/view/page/baiboly/recherche.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Baiboly extends StatelessWidget {
  const Baiboly({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          'assets/images/bgBaiboly_2.jpg',
          width: size.width,
          height: size.height,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              //Titre Baiboly Masina
              const Padding(
                padding: EdgeInsets.only(top: 40.0, bottom: 22.0),
                child: Text(
                  "Baiboly Masina",
                  style: TextStyle(
                    color: primary,
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              //Isan'ny boky isaky ny Testamenta
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Testamenta taloha
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/testaloha');
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: tertiary.withOpacity(0.6),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  "TESTAMENTA \n TALOHA",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: darken_1),
                                ),
                              ),
                            ),
                            Container(
                              height: 70,
                              padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                              decoration: BoxDecoration(
                                color: darken_1,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: FutureBuilder<int>(
                                  future: DatabaseHelper()
                                      .countBooks("Testamenta taloha"),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        "${snapshot.data!} \n BOKY",
                                        style: const TextStyle(
                                          color: tertiary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Testamenta vaovao
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/tesvaovao');
                      },
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  "TESTAMENTA \n VAOVAO",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: darken_1),
                                ),
                              ),
                            ),
                            Container(
                              height: 70,
                              padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                              decoration: BoxDecoration(
                                color: darken_1,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: FutureBuilder<int>(
                                  future: DatabaseHelper()
                                      .countBooks("Testamenta vaovao"),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        "${snapshot.data!} \n BOKY",
                                        style: const TextStyle(
                                          color: tertiary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Famakiana toko sy andininy
              Card(
                margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                color: primary,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(2),
                  leading: SvgPicture.asset(
                    'assets/images/icons/famakiana.svg',
                    color: secondary,
                    height: 48,
                  ),
                  title: const Text(
                    "Famakiana",
                    style: TextStyle(
                      color: secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    "Toko sy andinin-tSoratra Masina manokana",
                    style: TextStyle(color: tertiary, fontSize: 13),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/famakiana');
                  },
                ),
              ),

              // Fitadiavana teny
              Card(
                margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                color: primary,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(2),
                  leading: SvgPicture.asset(
                    'assets/images/icons/fitadiavana.svg',
                    color: secondary,
                    height: 48,
                  ),
                  title: const Text(
                    "Fitadiavana teny",
                    style: TextStyle(
                      color: secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    "Hitady teny amin’ny boky iray na boky manontolo",
                    style: TextStyle(color: tertiary, fontSize: 13),
                  ),
                  onTap: () {
                    //Naviguer vers la page de recherche
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecherchePage()),
                    );
                  },
                ),
              ),

              //Favoris
              Card(
                margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                color: primary,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(2),
                  leading: SvgPicture.asset(
                    'assets/images/icons/voatahiry.svg',
                    color: secondary,
                    height: 48,
                  ),
                  title: const Text(
                    "Andininy voatahiry",
                    style: TextStyle(
                      color: secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    "Ireo andininy notehirizinao",
                    style: TextStyle(color: tertiary, fontSize: 13),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavorisPage(),
                      ),
                    );
                  },
                ),
              ),

              //Fanitsiana
              Card(
                margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                color: primary,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(2),
                  leading: SvgPicture.asset(
                    'assets/images/icons/fanitsiana.svg',
                    color: secondary,
                    height: 48,
                  ),
                  title: const Text(
                    "Fanitsiana",
                    style: TextStyle(
                      color: secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    "Fakana ny fanintsiana farany raha toa ka misy nahitsy",
                    style: TextStyle(color: tertiary, fontSize: 13),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/fanitsiana');
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
