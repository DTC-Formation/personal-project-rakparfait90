import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';

class RaozeryMasina extends StatelessWidget {
  const RaozeryMasina({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
