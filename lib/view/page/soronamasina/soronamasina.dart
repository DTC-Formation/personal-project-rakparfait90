import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';

class SoronaMasina extends StatelessWidget {
  const SoronaMasina({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            color: secondary,
          ),
          const Center(
            child: Text(
              'Sorona Masina',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
