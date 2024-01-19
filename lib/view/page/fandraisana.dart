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
import 'package:flutter_svg/flutter_svg.dart';

class Fandraisana extends StatefulWidget {
  const Fandraisana({super.key});

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
      backgroundColor: lighten_3,
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
      backgroundColor: darken_1,
      unselectedItemColor: tertiary,
      selectedItemColor: secondary,
      currentIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/icons/fiangonana.svg',
            color: selectedIndex == 0 ? secondary : tertiary,
            height: 32,
          ),
          label: "Fandraisana",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/icons/baiboly.svg',
            color: selectedIndex == 1 ? secondary : tertiary,
            height: 32,
          ),
          label: "Baiboly",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/icons/sorona-masina.svg',
            color: selectedIndex == 2 ? secondary : tertiary,
            height: 32,
          ),
          label: "Sorona Masina",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/icons/fihirana.svg',
            color: selectedIndex == 3 ? secondary : tertiary,
            height: 32,
          ),
          label: "Fihirana",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/icons/rozery.svg',
            color: selectedIndex == 4 ? secondary : tertiary,
            height: 32,
          ),
          label: "Raozery",
        )
      ],
      onTap: (int index) {
        onTapHandler(index);
      },
    );
  }
}
