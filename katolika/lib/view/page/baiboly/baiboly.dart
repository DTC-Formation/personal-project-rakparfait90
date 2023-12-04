import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/appbar.dart';
import 'package:katolika/view/bottomnavigation.dart';
import 'package:katolika/view/drawer.dart';
import 'package:katolika/view/page/recherchepage.dart';

class Baiboly extends StatelessWidget {
  const Baiboly({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const HeaderBar(),
      body: Column(
        children: [
          Container(
            height: 50,
            width: size.width,
            color: tealBlue,
            child: const Center(
              child: Text(
                "BAIBOLY MASINA",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
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
                                color: Colors.grey.withOpacity(0.6),
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
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                          decoration: BoxDecoration(
                            color: tealBlue,
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
                                    style: const TextStyle(color: Colors.white),
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
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                          decoration: BoxDecoration(
                            color: tealBlue,
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
                                    style: const TextStyle(color: Colors.white),
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
          Card(
            margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
            color: primary,
            child: ListTile(
              contentPadding: const EdgeInsets.all(2),
              leading:
                  Image.asset('assets/images/icons/famakiana.png', height: 48),
              title: const Text(
                "Famakiana",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                "Toko sy andinin-tSoratra Masina manokana",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/famakiana');
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
            color: primary,
            child: ListTile(
              contentPadding: const EdgeInsets.all(2),
              leading: Image.asset('assets/images/icons/fitadiavana.png',
                  height: 48),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RecherchePage()),
                );
              },
            ),
          ),
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
      ),
      bottomNavigationBar: const BottomNavigation(),
      //Navbar
      drawer: const SideBarDrawer(),
    );
  }
}
