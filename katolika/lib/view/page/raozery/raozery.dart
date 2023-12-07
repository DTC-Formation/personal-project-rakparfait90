import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/appbar.dart';
import 'package:katolika/view/bottomnavigation.dart';
import 'package:katolika/view/drawer.dart';

class RaozeryMasina extends StatelessWidget {
  const RaozeryMasina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBar(),
      body: Center(
        child: Stack(
          children: [
            Container(
              color: tealBlue,
            ),
            const Center(
              child: Text(
                'Raozery Masina',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
      //Navbar
      drawer: const SideBarDrawer(),
    );
  }
}
