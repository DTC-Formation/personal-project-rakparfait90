import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/baiboly/baiboly.dart';
import 'package:katolika/view/page/baiboly/famakiana.dart';
import 'package:katolika/view/page/baiboly/testamenta_taloha.dart';
import 'package:katolika/view/page/baiboly/testamenta_vaovao.dart';
import 'package:katolika/view/page/fihirana/fihirana.dart';
import 'package:katolika/view/page/homepage.dart';
import 'package:katolika/view/page/raozery/raozery.dart';
import 'package:katolika/view/page/soronamasina/soronamasina.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katolika aho',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: tealBlue),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/baiboly': (context) => const Baiboly(),
        '/testaloha': (context) => const TestamentaTaloha(),
        '/tesvaovao': (context) => const TestamentaVaovao(),
        '/famakiana': (context) => const FamakianaManokana(),
        '/soronaMasina': (context) => const SoronaMasina(),
        '/raozery': (context) => const RaozeryMasina(),
        '/fihirana': (context) => const FihiranaKatolika(),
      },
      home: const MyHomePage(),
    );
  }
}
