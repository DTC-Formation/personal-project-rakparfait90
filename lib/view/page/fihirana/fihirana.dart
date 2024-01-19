import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/fihirana/lisitrafihirana.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FihiranaKatolika extends StatelessWidget {
  const FihiranaKatolika({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          'assets/images/bgFihirana.jpg',
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
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                "Fihirana Katolika",
                style: TextStyle(
                  color: primary,
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 2,
                      offset: Offset(0, 0.2),
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                    ),
                  ],
                ),
              ),
            ),
            //Lisitry ny fihirana
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                          "Lisitry ny fihirana",
                          style: TextStyle(
                            color: secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: const Text(
                          "Ahitana ny lisitry ny fihirana voatahiry sy mijery ny fanoroam-pejy",
                          style: TextStyle(
                            color: tertiary,
                            fontSize: 13,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      FadeTransition(
                                opacity: animation,
                                child: const LisitraFihirana(),
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
                        leading: SvgPicture.asset(
                          'assets/images/icons/fitadiavana.svg',
                          color: secondary,
                          height: 48,
                        ),
                        title: const Text(
                          "Fitadiavana hira",
                          style: TextStyle(
                            color: secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: const Text(
                          "Fitadiavana hira araky ny lohateny",
                          style: TextStyle(color: tertiary, fontSize: 13),
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
                        leading: SvgPicture.asset(
                          'assets/images/icons/salamo.svg',
                          color: secondary,
                          height: 48,
                        ),
                        title: const Text(
                          "Salamo",
                          style: TextStyle(
                            color: secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: const Text(
                          "Lisitry ny Salamo araky ny filaharany",
                          style: TextStyle(color: tertiary, fontSize: 13),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/salamo');
                        },
                      ),
                    ),
                    //Hira rehetra
                    Card(
                      margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                      color: primary,
                      child: ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(6, 2, 2, 2),
                        leading: SvgPicture.asset(
                          'assets/images/icons/sokajyhira.svg',
                          color: secondary,
                          height: 48,
                        ),
                        title: const Text(
                          "Sokajy rehetra",
                          style: TextStyle(
                            color: secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: const Text(
                          "Lisitry ny hira araky ny sokajiny ampiasaina amin'ny litorjia",
                          style: TextStyle(color: tertiary, fontSize: 13),
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
                        leading: SvgPicture.asset(
                          'assets/images/icons/voatahiry.svg',
                          color: secondary,
                          height: 48,
                        ),
                        title: const Text(
                          "Ireo hira notehirizinao",
                          style: TextStyle(
                            color: secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: const Text(
                          "Lisitry ny hira notehirizinao mba ho mora hiverenana amin'ny manaraka",
                          style: TextStyle(color: tertiary, fontSize: 13),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/voatahiry');
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
                          "Fakana ny fanintsiana farany raha toa ka misy nahitsy na nisy hira vaovao nampidirina",
                          style: TextStyle(color: tertiary, fontSize: 13),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/fanitsiana');
                        },
                      ),
                    ),
                    //

                    //
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
