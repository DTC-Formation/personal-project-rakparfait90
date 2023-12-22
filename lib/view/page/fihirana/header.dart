import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';

class HeaderFihirana extends StatefulWidget implements PreferredSizeWidget {
  const HeaderFihirana({super.key});

  @override
  State<HeaderFihirana> createState() => _HeaderFihiranaState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _HeaderFihiranaState extends State<HeaderFihirana> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: Image.asset('assets/images/icons/fihirana_w.png', height: 28),
      ),
      backgroundColor: secondary,
      title: const Text(
        'Fihirana Katolika',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
