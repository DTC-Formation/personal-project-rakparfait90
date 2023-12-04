import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/baiboly/baiboly.dart';
import 'package:katolika/view/page/baiboly/famakiana.dart';
import 'package:katolika/view/page/baiboly/testamenta_taloha.dart';
import 'package:katolika/view/page/baiboly/testamenta_vaovao.dart';
import 'package:katolika/view/page/homepage.dart';

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
        // '/soronamasina': (context) => const SoronaMasina(),
        // '/raozery': (context) => const Raozery(),
        // '/fihirana': (context) => const Fihirana(),
        '/testaloha': (context) => const TestamentaTaloha(),
        '/tesvaovao': (context) => const TestamentaVaovao(),
        '/famakiana': (context) => const FamakianaManokana(),
      },
      home: const MyHomePage(),
    );
  }
}
