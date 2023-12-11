import 'dart:core';
import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/baiboly/baiboly.dart';
import 'package:katolika/view/page/mystories.dart';
import 'package:katolika/view/page/raozery/raozery.dart';
import 'package:katolika/view/page/soronamasina/soronamasina.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  Widget fandraisana = const MyStories();
  Widget baiboly = const Baiboly();
  Widget soronaMasina = const SoronaMasina();
  Widget raozery = const RaozeryMasina();

  @override
  Widget build(BuildContext context) {
    // const List<BottomNavigationItems> items = BottomNavigationItems.values;
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
          icon: Image.asset('assets/images/icons/rozery.png', height: 42),
          label: "Raozery",
        )
      ],
      onTap: (int index) {
        onTapHandler(index);
      },
    );
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return fandraisana;
    } else if (selectedIndex == 1) {
      return baiboly;
    } else if (selectedIndex == 2) {
      return soronaMasina;
    } else {
      return raozery;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
