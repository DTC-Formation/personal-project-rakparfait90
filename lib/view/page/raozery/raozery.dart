import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katolika/model/color.dart';

class RaozeryMasina extends StatelessWidget {
  const RaozeryMasina({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(const ClipboardData(text: 'Raozery Masina'));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Texte copié'),
          ),
        );
      },
      child: Center(
        child: Stack(
          children: [
            Container(
              color: secondary,
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
    );
  }
}
