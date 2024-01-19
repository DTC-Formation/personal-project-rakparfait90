import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class VotoatinySoronaMasina extends StatefulWidget {
  final int idSoronaMasina;
  final String datyGasy;
  final String herinAndro;
  final String vanimPotoana;
  final String taona;
  final String? tononkira;
  final String? fangatahana;
  final String vk1;
  final String vk1Soratra;
  final String salamo;
  final String salamoSoratra;
  final String vk2;
  final String vk2Soratra;
  final String? aleloia;
  final String evanjely;
  final String evanjelySoratra;
  final String? ranombavaka;
  final String? ranombavakaFiv;
  final String? ranombavakaSoratra;
  final String? ranombavakaPretra;
  final String? vavakaFanolorana;
  final String? komonio;
  final String? vavakaKomonio;

  const VotoatinySoronaMasina({
    required this.idSoronaMasina,
    required this.datyGasy,
    required this.herinAndro,
    required this.vanimPotoana,
    required this.taona,
    required this.tononkira,
    required this.fangatahana,
    required this.vk1,
    required this.vk1Soratra,
    required this.salamo,
    required this.salamoSoratra,
    required this.vk2,
    required this.vk2Soratra,
    required this.aleloia,
    required this.evanjely,
    required this.evanjelySoratra,
    required this.ranombavaka,
    required this.ranombavakaFiv,
    required this.ranombavakaSoratra,
    required this.ranombavakaPretra,
    required this.vavakaFanolorana,
    required this.komonio,
    required this.vavakaKomonio,
    super.key,
  });

  @override
  State<VotoatinySoronaMasina> createState() => _VotoatinySoronaMasinaState();
}

class _VotoatinySoronaMasinaState extends State<VotoatinySoronaMasina> {
  String getFirstWord(String text) {
    if (text.isEmpty) return "";
    final words = text.split(' ');
    return words[0];
  }

  final ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lighten_1,
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(color: lighten_1),
        iconTheme: const IconThemeData(color: lighten_1),
        backgroundColor: manga,
        centerTitle: true,
        title: Text(
          widget.datyGasy,
          style: const TextStyle(color: lighten_1, fontSize: 24.0),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final Uint8List? image = await screenshotController.capture();
              if (image != null) {
                final directory = await getApplicationDocumentsDirectory();
                final imagePath =
                    await File('${directory.path}/${widget.datyGasy}.jpg')
                        .create();
                await imagePath.writeAsBytes(image);

                final tempDir = await getTemporaryDirectory();
                final file =
                    await File('${tempDir.path}/${widget.datyGasy}.jpg')
                        .create();
                await file.writeAsBytes(image);

                final result = await Share.shareXFiles([XFile(file.path)],
                    text:
                        'Sorona Masina ${widget.datyGasy}. Fizarana avy amin\'ny Application Katolika aho');

                if (result.status == ShareResultStatus.success) {
                  print('Misaotra anao nizara ity Sorona Masina ity!');
                }
              }
            },
          ),
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.herinAndro} ${widget.vanimPotoana}',
                    style: const TextStyle(
                      color: mena,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    widget.taona,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "Tononkira fidirana",
                      style: TextStyle(
                        color: mena,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                    child: Text(
                      widget.tononkira ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  if (getFirstWord(widget.datyGasy) == 'Alahady')
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "Asiana VONINAHITRA ANIE ... ",
                        style: TextStyle(
                          color: mena,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "Fangatahana",
                      style: TextStyle(
                        color: mena,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      widget.fangatahana ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: primary,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Fankalazana ny Tenin'Andriamanitra",
                      style: TextStyle(
                        color: primary,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: RichText(
                      text: TextSpan(
                        text: "Vakinteny voalohany : ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: darken_2,
                          fontSize: 18,
                        ),
                        children: [
                          WidgetSpan(
                            child: Text(
                              widget.vk1,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "    ${widget.vk1Soratra}",
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                      // textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: RichText(
                      text: TextSpan(
                        text: "Setriny : ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: darken_2,
                          fontSize: 18,
                        ),
                        children: [
                          WidgetSpan(
                            child: Text(
                              widget.salamo,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      widget.salamoSoratra,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                      // textAlign: TextAlign.justify,
                    ),
                  ),
                  if (widget.vk2 != '')
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: RichText(
                        text: TextSpan(
                          text: "Vakinteny faharoa : ",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darken_2,
                            fontSize: 18,
                          ),
                          children: [
                            WidgetSpan(
                              child: Text(
                                widget.vk2,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "    ${widget.vk2Soratra}",
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                      // textAlign: TextAlign.justify,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "Fihobiana ny Evanjely",
                      style: TextStyle(
                        color: mena,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
                    child: Text(
                      widget.aleloia ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: RichText(
                      text: TextSpan(
                        text: "Evanjely Masin'i Jesoa Kristy : ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: darken_2,
                          fontSize: 18,
                        ),
                        children: [
                          WidgetSpan(
                            child: Text(
                              widget.evanjely,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "    ${widget.evanjelySoratra}",
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                      // textAlign: TextAlign.justify,
                    ),
                  ),
                  if (getFirstWord(widget.datyGasy) == 'Alahady')
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "Asiana IZAHO MINO ... ",
                        style: TextStyle(
                          color: mena,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (getFirstWord(widget.datyGasy) == 'Alahady')
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "Ranombavaky ny mpino",
                        style: TextStyle(
                          color: mena,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  if (widget.ranombavaka != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "    ${widget.ranombavaka}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  if (widget.ranombavakaFiv != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                      child: Text(
                        "Valy : ${widget.ranombavakaFiv}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                    child: Text(
                      widget.ranombavakaSoratra ?? '',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  if (widget.ranombavaka != null)
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
                      child: Text(
                        "-Azo ampiana izay ilaina eo an-toerana sy eran-tany",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: mena,
                        ),
                      ),
                    ),
                  if (widget.ranombavakaPretra != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "    ${widget.ranombavakaPretra}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "Vavaka Fanolorana",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: mena,
                      ),
                    ),
                  ),
                  if (widget.vavakaFanolorana != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "    ${widget.vavakaFanolorana}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "Kômonio",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "    ${widget.komonio}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "Vavaka aorian'ny Kômonio",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: mena,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "    ${widget.vavakaKomonio}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
