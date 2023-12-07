import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';

enum BottomNavigationItems {
  fandraisana,
  baiboly,
  soronaMasina,
  raozery;

  String get routeName => name == 'fandraisana' ? '/' : '/$name';
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // const List<BottomNavigationItems> items = BottomNavigationItems.values;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: tealBlue,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          Navigator.of(context).pushNamed(
            BottomNavigationItems.values[index].routeName,
          );
        });
      },
      items: [
        buildBottomNavigationBarItem(
          icon: 'assets/images/icons/fiangonana.png',
          label: 'Fandraisana',
          item: BottomNavigationItems.fandraisana,
        ),
        buildBottomNavigationBarItem(
          icon: 'assets/images/icons/baiboly.png',
          label: 'Baiboly',
          item: BottomNavigationItems.baiboly,
        ),
        buildBottomNavigationBarItem(
          icon: 'assets/images/icons/sorona-masina.png',
          label: 'Sorona Masina',
          item: BottomNavigationItems.soronaMasina,
        ),
        buildBottomNavigationBarItem(
          icon: 'assets/images/icons/rozery.png',
          label: 'Raozery',
          item: BottomNavigationItems.raozery,
        ),
      ],
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String icon,
    required String label,
    required BottomNavigationItems item,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(icon, height: 42),
      label: label,
      backgroundColor: _selectedIndex == item.index ? tealBlue : null,
    );
  }
}
