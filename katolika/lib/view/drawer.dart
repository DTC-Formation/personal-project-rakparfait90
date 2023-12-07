import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';

class SideBarDrawer extends StatefulWidget {
  const SideBarDrawer({super.key});

  @override
  State<SideBarDrawer> createState() => _SideBarDrawerState();
}

class _SideBarDrawerState extends State<SideBarDrawer> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            alignment: const Alignment(-0.7, 0.2),
            height: 100,
            color: secondary,
            child: const Text(
              'KATOLIKA AHO',
              style: TextStyle(
                color: tealBlue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                controller: ScrollController(),
                children: [
                  ListTile(
                    leading: Image.asset(
                      'assets/images/icons/fihirana.png',
                      height: 30,
                    ),
                    title: const Text("Fihirana Katolika"),
                    onTap: () => Navigator.of(context).pushNamed('/fihirana'),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/icons/lamesa.png',
                      height: 30,
                    ),
                    title: const Text("Lamesa"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/icons/fandalinana_finoana.png',
                      height: 30,
                    ),
                    title: const Text("Fandalinam-pinoana"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/icons/toriteny.png',
                      height: 30,
                    ),
                    title: const Text("Tori-teny"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/icons/fanajana_manokana.png',
                      height: 30,
                    ),
                    title: const Text("Fanajana manokana"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/icons/vavaka.png',
                      height: 30,
                    ),
                    title: const Text("Vavaka"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/icons/hasivianandro.png',
                      height: 30,
                    ),
                    title: const Text("Hasivian'andro"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/icons/litania.png',
                      height: 30,
                    ),
                    title: const Text("Litania"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/icons/lalan-ny-hazo-fijaliana.png',
                      height: 30,
                    ),
                    title: const Text("Làlan'ny Hazofijaliana"),
                    onTap: () => Navigator.pop(context),
                  ),

                  // ilay espace vide
                  const SizedBox(
                    height: 60,
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.info_outline_rounded,
                      size: 30,
                    ),
                    title: const Text("Momba ny rindrankajy"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    title: const Text("Fikirakirana"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(
                      color: Colors.red,
                      Icons.exit_to_app,
                      size: 30,
                    ),
                    title: const Text("Hiala"),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
