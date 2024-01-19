import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyStories extends StatefulWidget {
  const MyStories({super.key});

  @override
  State<MyStories> createState() => _MyStoriesState();
}

class _MyStoriesState extends State<MyStories> {
  // final YoutubePlayerController _controller = VideoController().controller;

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  void _showDialog(BuildContext context, var size, String header, String text) {
    showDialog(
      barrierColor: darken_1.withOpacity(0.8),
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 50),
              child: Container(
                padding: const EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                  color: lighten_2,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: size.width,
                      padding: const EdgeInsets.fromLTRB(18, 24, 18, 24),
                      decoration: BoxDecoration(
                        color: lighten_2,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 0.1,
                            blurRadius: 2,
                            offset: const Offset(0, 0.5),
                          ),
                        ],
                      ),
                      child: Text(
                        header,
                        style: const TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(text),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 3,
              top: 55,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                child: TextButton(
                  child: const Icon(
                    Icons.close,
                    color: lighten_1,
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper().getEvanjelyAnio(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final evanjelyAnio = snapshot.data!.first;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // //Début Lamesa mivantana
                // Container(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Center(
                //     child: RichText(
                //       text: const TextSpan(
                //         text: "Lamesa mivantana anio: ",
                //         style: TextStyle(
                //           fontSize: 19,
                //           color: primary,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     padding: const EdgeInsets.all(8.0),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(5.0),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.2),
                //           spreadRadius: 1,
                //           blurRadius: 2,
                //           offset: const Offset(0, 1),
                //         ),
                //       ],
                //     ),
                //     child: YoutubePlayer(
                //       controller: _controller,
                //       showVideoProgressIndicator: true,
                //     ),
                //   ),
                // ),
                // //fin Lamesa mivantana

                Stack(
                  children: [
                    Image.asset(
                      'assets/images/evanjelyanio.png',
                      width: size.width,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 8,
                      child: Text(
                        "KATOLIKA AHO",
                        style: TextStyle(
                          color: secondary,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),

                // Evanjely anio
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      evanjelyAnio['daty_gasy'].toUpperCase(),
                                      style: const TextStyle(color: lighten_1),
                                    ),
                                    Text(
                                      "${evanjelyAnio['herinandro'].toString().replaceFirst("HER.", "HERINANDRO").toUpperCase()} ${evanjelyAnio['vanimpotoana'].toUpperCase()}",
                                      style: const TextStyle(
                                        color: lighten_1,
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            //
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Tonon-kira fidirana
                                  Text(
                                    "\"${evanjelyAnio['tononkira_fidirana']}\"",
                                    style: const TextStyle(
                                      color: primary,
                                      fontSize: 16.5,
                                    ),
                                  ),

                                  // Vakiteny voalohany
                                  RichText(
                                    text: TextSpan(
                                      text: "Vakinteny I : ",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: darken_2,
                                      ),
                                      children: [
                                        WidgetSpan(
                                          child: GestureDetector(
                                            onTap: () => _showDialog(
                                                context,
                                                size,
                                                "Vakiteny I: ${evanjelyAnio['vkt1']}",
                                                evanjelyAnio['vkt1_soratra']),
                                            child: Text(
                                              " ${evanjelyAnio['vkt1']} ",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.5,
                                                color: primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //Salamo
                                  RichText(
                                    text: TextSpan(
                                      text: "Salamo: ",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        height: 1.5,
                                        color: darken_2,
                                      ),
                                      children: [
                                        WidgetSpan(
                                          child: GestureDetector(
                                            onTap: () => _showDialog(
                                              context,
                                              size,
                                              "Salamo: ${evanjelyAnio['salamo'].toString().replaceFirst("Sal", "")}",
                                              evanjelyAnio['salamo_soratra'],
                                            ),
                                            child: Text(
                                              " ${evanjelyAnio['salamo'].toString().replaceFirst("Sal", "")} ",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.5,
                                                color: primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Vakiteny faharoa
                                  if (evanjelyAnio['vkt2'] != '')
                                    RichText(
                                      text: TextSpan(
                                        text: "Vakinteny II : ",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                          color: darken_2,
                                        ),
                                        children: [
                                          WidgetSpan(
                                            child: GestureDetector(
                                              onTap: () => _showDialog(
                                                  context,
                                                  size,
                                                  "Vakiteny II: ${evanjelyAnio['vkt2']}",
                                                  evanjelyAnio['vkt2_soratra']),
                                              child: Text(
                                                " ${evanjelyAnio['vkt2']} ",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.5,
                                                  color: primary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  // Evanjely
                                  RichText(
                                    text: TextSpan(
                                      text: "Evanjely: ",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        height: 1.5,
                                        color: darken_2,
                                      ),
                                      children: [
                                        WidgetSpan(
                                          child: GestureDetector(
                                            onTap: () => _showDialog(
                                                context,
                                                size,
                                                "Evanjely: ${evanjelyAnio['evanjely']}",
                                                evanjelyAnio[
                                                    'evanjely_soratra']),
                                            child: Text(
                                              " ${evanjelyAnio['evanjely']} ",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.5,
                                                color: primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //Kintan'ny finoana
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                color: darken_1,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "KINTAN'NY FINOANA",
                                      style: TextStyle(color: lighten_1),
                                    ),
                                    Text(
                                      "TANTARAN'NY OLOMASINA TSAROAN'NY FIANGONANA ANIO",
                                      style: TextStyle(
                                        color: lighten_1,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FutureBuilder<List<Map<String, dynamic>>>(
                                future: DatabaseHelper().getOlomasina(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else {
                                    final olomasina = snapshot.data!.first;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/olomasina/${olomasina['olomasina_image']}',
                                              width: size.width,
                                              height: 220,
                                              fit: BoxFit.cover,
                                            ),
                                            Container(
                                              width: size.width,
                                              color: darken_1,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                olomasina['olomasina'],
                                                style: const TextStyle(
                                                  color: secondary,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "TANTARANY",
                                            style: TextStyle(
                                              color: primary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),

                                        // tantaran'ny olomasina
                                        Builder(
                                          builder: (context) {
                                            var olomasinaTantara =
                                                olomasina['olomasina_tantara'];
                                            if (olomasinaTantara == null) {
                                              return const Text(
                                                  "Mbola tsy vonona ny tantaran'ny olomasina anio");
                                            } else {
                                              return Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      Text(olomasinaTantara));
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class VideoController {
  final YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: 'M_QlXwkBXFE',
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
      isLive: true,
      loop: false,
    ),
  );
}
