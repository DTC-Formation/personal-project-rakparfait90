import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/baiboly/famakiana.dart';
import 'package:katolika/view/page/baiboly/testamenta_taloha.dart';
import 'package:katolika/view/page/baiboly/testamenta_vaovao.dart';
import 'package:katolika/view/page/fandraisana.dart';
import 'package:katolika/view/page/fihirana/fihirana.dart';

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
        '/testaloha': (context) => const TestamentaTaloha(),
        '/tesvaovao': (context) => const TestamentaVaovao(),
        '/famakiana': (context) => const FamakianaManokana(),
        '/fihirana': (context) => const FihiranaKatolika(),
      },
      home: const Fandraisana(),
    );
  }
}
