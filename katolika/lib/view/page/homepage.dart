import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/appbar.dart';
import 'package:katolika/view/drawer.dart';
import 'package:katolika/view/bottomnavigation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'M_QlXwkBXFE',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
      isLive: true,
      loop: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const HeaderBar(),
      //AppBar
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Début Lamesa mivantana
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: RichText(
                  text: const TextSpan(
                    text: "Lamesa mivantana anio: ",
                    style: TextStyle(
                      fontSize: 19,
                      color: primary,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                ),
              ),
            ),
            //fin Lamesa mivantana
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: tealBlue,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: RichText(
                          text: const TextSpan(
                            text: 'Zoma 22 Septembre 2023',
                            style: TextStyle(fontSize: 19),
                            children: [
                              TextSpan(text: '\n'),
                              TextSpan(
                                  text: 'Herinandro faha-24 mandavantaona',
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: RichText(
                        text: const TextSpan(
                          text:
                              "\"Omeo fiadanana ireo manantena anao, ry Tompo, enga anie ho masin-teny ny mpaminany; henoy ny vavak'i Israely mpanomponao sy vahoakanao\"",
                          style: TextStyle(
                            color: primary,
                            height: 1.2,
                          ),
                          children: [
                            TextSpan(text: '\n'),
                            TextSpan(
                              text: "Vak1: 1 Tim, 6. 2d-12",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),
                            TextSpan(text: '\n'),
                            TextSpan(
                              text: "Sal: 48, 6-7.8-10.17-18.19-20",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),
                            TextSpan(text: '\n'),
                            TextSpan(
                              text: "Evanj: Lk 8, 1-3",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: RichText(
                          text: const TextSpan(
                            text: "Kintan'ny finoana",
                            style: TextStyle(fontSize: 19),
                            children: [
                              TextSpan(text: '\n'),
                              TextSpan(
                                  text:
                                      "Tantaran'ny Olomasina tsaroan'ny fiangonana anio",
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: RichText(
                        text: const TextSpan(
                          text:
                              "01 nôvambra — Taloha dia tao aorian'ny fetin'ny Paka na ny alahady manaraka ny Pantekôty ny fankalazana ny fetin'ny Olomasina rehetra. Tamin'ny taonjato fahadimy dia ny zoman'ny Paka no nankalazana izany tany Syrie, fa ny tany Roma kosa tamin'io vanim-potoana io dia nomarihana tamin'ny alahady ao aorian'ny Pantekôty. \n Rehefa novaina ho sanctuaire ho an'ny kristianina ny Pathéon tao Roma, dia notsofin'ny papa Boniface IV rano izany ny 13 mey 610, ary nomena ny anarana hoe fiangonana Sainte-Marie-et-des-Martyrs. Te hitana ity daty ity ho fahatsiarovana ireo martiry najaina tao amin'ny sactuaire ny papa ka dia notanana io daty io, izay nitokanana ny fiangonana ho fankalazana ny martiry rehetra. Noheverina fa tamin'ny papa Grégoire III no nanomboka ny fankalazana ny fetin'ny olomasina rehetra isaky ny 01 nôvambra. Tamin'ny fitokanana ny chapelle tao amin'ny bazilikan'i Masindahy Pierre tao Roma, ho fanajana ny olomasina rehetra izany. Ny taona 830 ny papa Grégoire IV no namoaka baiko na didy fa ankalazaina maneran-tany io fetin'ny 01 nôvambra ho fankalazana sy fahatsiarovana ny olomasina io. Ambaran'ireo mpikaroka sasany fa ny fandraisana ny fanapahan-kevitra tamin'ny taona 835 no namaritana ity datin'ny 01 nôvambra ity. \n Ny fankalazana ny fetin'ny olomasina, ny 01 nôvambra, araka ny nambara teny am-piandohana dia natao ho an'ny olomasina rehetra. Araka ny voalazan'i Robert Le Gall dia tsy ho an'izay nasandratry ny Fiangonana ho olomasina fotsiny, izay efa any amin'ny voninahitr'Adriamanitra, ity fankalazana ity, fa indrindra ihany koa ho an'ireo olona marobe niaina ny hatsaram-panahin'Andriamanitra. Noho izany, tsy hoe nasandratra izy ireo na tsia, fa ireo rehetra izay nanamasina ny tenany tamn'ny asa fiantrana, ny fandraisana ny famindram-po sy ny fanomezam-pahasoavana avy amin'Andriamanitra, dia ankalazaina daholo. Ity fety ity, noho izany, dia mampiahatsiahy antsika mpino rehetra fa antso ho an'ny rehetra ny fahamasinana. Amin'ity fankalazana ity ny Fiangonana dia maneho sy mampahatsiahy antsika ireo toe-panahy ao amin'ny Soratra Masina, ary manosika antsika hiezaka ho amin'izany fahamasinana izany. Marihana fa tamin'ny taonjato faharoapolo ny papa Pie X no nampiditra ity daty ity ho andro voadidy ho hamasinina, ka ny vavaka rehetra dia mankany amin'Andriamanitra. Noho izany tsy hoe mivavaka amin'ny olomasina isika, fa mangataka ny fanelanelanan'izy ireo amin'Andriamanitra sy i Jesoa ho antsika. Amin'ny fiantsoana ny olomasiana, ny Fiangonana ety an-tany dia miantso ny fanampian'ny Fiangonana any an-danitra, ary izay no mahatonga antsika isaky ny miantso ny olomasina dia manao hoe \"Mivavaha, ho anay\"",
                          style: TextStyle(
                            color: primary,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      //body
      bottomNavigationBar: const BottomNavigation(),
      //Navbar
      drawer: const SideBarDrawer(),
    );
  }
}
