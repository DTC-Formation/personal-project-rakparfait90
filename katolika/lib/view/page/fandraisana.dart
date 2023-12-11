import 'dart:core';
import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/appbar.dart';
import 'package:katolika/view/drawer.dart';
import 'package:katolika/view/page/baiboly/baiboly.dart';
import 'package:katolika/view/page/fihirana/fihirana.dart';
import 'package:katolika/view/page/mystories.dart';
import 'package:katolika/view/page/raozery/raozery.dart';
import 'package:katolika/view/page/soronamasina/soronamasina.dart';

class Fandraisana extends StatefulWidget {
  const Fandraisana({Key? key}) : super(key: key);

  @override
  State<Fandraisana> createState() => _FandraisanaState();
}

class _FandraisanaState extends State<Fandraisana> {
  int selectedIndex = 0;
  Widget mystories = const MyStories();
  Widget baiboly = const Baiboly();
  Widget soronaMasina = const SoronaMasina();
  Widget fihirana = const FihiranaKatolika();
  Widget raozery = const RaozeryMasina();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBar(),
      body: getBody(),
      drawer: const SideBarDrawer(),
      bottomNavigationBar: navBar(),
    );
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return mystories;
    } else if (selectedIndex == 1) {
      return baiboly;
    } else if (selectedIndex == 2) {
      return soronaMasina;
    } else if (selectedIndex == 3) {
      return fihirana;
    } else {
      return raozery;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget navBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: tealBlue,
      currentIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/icons/fiangonana.png', height: 42),
          label: "Fandraisana",
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/icons/baiboly.png', height: 42),
          label: "Baiboly",
        ),
        BottomNavigationBarItem(
          icon:
              Image.asset('assets/images/icons/sorona-masina.png', height: 42),
          label: "Sorona Masina",
        ),
        BottomNavigationBarItem(
          icon:
              Image.asset('assets/images/icons/sorona-masina.png', height: 42),
          label: "Fihirana",
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/icons/rozery.png', height: 42),
          label: "Raozery",
        )
      ],
      onTap: (int index) {
        onTapHandler(index);
      },
    );
  }
}
