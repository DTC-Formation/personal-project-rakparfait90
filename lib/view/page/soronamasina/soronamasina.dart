import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/baiboly/favoris_page.dart';
import 'package:katolika/view/page/baiboly/recherche.dart';

class SoronaMasina extends StatelessWidget {
  const SoronaMasina({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          'assets/images/soronaMasina_2.jpg',
          width: size.width,
          height: size.height,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: darken_2.withOpacity(0.5),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              //Titre Sorona Masina
              const Padding(
                padding: EdgeInsets.only(top: 40.0, bottom: 22.0),
                child: Text(
                  "SORONA MASINA",
                  style: TextStyle(
                    color: primary,
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              //Famakiana toko sy andininy
              Card(
                margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                color: primary,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  title: const Center(
                    child: Text(
                      "SORONA MASINA",
                      style: TextStyle(
                        color: tertiary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/soronamasinaListra');
                  },
                ),
              ),

              // Fitadiavana teny
              Card(
                margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                color: primary,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  title: const Center(
                    child: Text(
                      "FIZOTRY NY LAMESA",
                      style: TextStyle(
                        color: tertiary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                  contentPadding: const EdgeInsets.all(20),
                  title: const Center(
                    child: Text(
                      "PREFASY",
                      style: TextStyle(
                        color: tertiary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
            ],
          ),
        ),
      ],
    );
  }
}
