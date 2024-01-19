import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/soronamasina/votoatinysoronamasina.dart';
import 'package:intl/intl.dart';

class SoronaMasinaLisitra extends StatefulWidget {
  const SoronaMasinaLisitra({super.key});

  @override
  State<SoronaMasinaLisitra> createState() => _SoronaMasinaLisitraState();
}

class _SoronaMasinaLisitraState extends State<SoronaMasinaLisitra> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> items = [];
  bool isFetchingMore = false;
  bool hasMoreData = true;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _fetchInitialData() async {
    var initialItems =
        await DatabaseHelper().getSoronaMasina(page: currentPage);
    if (initialItems.isNotEmpty) {
      setState(() {
        items.addAll(initialItems);
        currentPage++;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        hasMoreData) {
      _fetchMoreData();
    }
  }

  Future<void> _fetchMoreData() async {
    if (isFetchingMore) return;
    setState(() => isFetchingMore = true);

    try {
      var newItems = await DatabaseHelper().getSoronaMasina(page: currentPage);
      if (newItems.isNotEmpty) {
        setState(() {
          items.addAll(newItems);
          currentPage++;
        });
      } else {
        setState(() => hasMoreData = false);
      }
    } catch (e) {
      setState(() => hasMoreData = false);
    }
    setState(() => isFetchingMore = false);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Color _getColorFromName(String? colorName) {
    const defaultColor = Colors.green;
    if (colorName == null) {
      return defaultColor;
    } else {
      switch (colorName) {
        case 'green':
          return Colors.green;
        case 'white':
          return Colors.white;
        case 'red':
          return Colors.red;
        case 'purple':
          return Colors.purple.shade900;
        default:
          return Colors.transparent;
      }
    }
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  String formatDate(String date) {
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(date);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lighten_2,
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(color: lighten_1),
        iconTheme: const IconThemeData(color: lighten_1),
        backgroundColor: primary,
        centerTitle: true,
        title: const Text(
          'Sorona Masina',
          style: TextStyle(color: lighten_1, fontSize: 28.0),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: items.length + (hasMoreData ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index == items.length && hasMoreData) {
            return const Center(child: CircularProgressIndicator());
          }
          var item = items.elementAt(index);
          var loko = item['loko'];
          final idSoronaMasina = item['id'] as int;
          final datyGasy = item['daty_gasy'] as String;
          final herinAndro = capitalizeFirstLetter(
              item['herinandro'].toString().replaceFirst("HER.", "HERINANDRO"));
          final vanimPotoana = capitalizeFirstLetter(item['vanimpotoana']);
          final taona = item['num_taona'] as String;
          final String? tononkira = item['tononkira_fidirana'];
          final String? fangatahana = item['fangatahana'];
          final String vk1 = item['vkt1'];
          final String vk1Soratra = item['vkt1_soratra'];
          final String salamo = item['salamo'];
          final String salamoSoratra = item['salamo_soratra'];
          final String vk2 = item['vkt2'];
          final String vk2Soratra = item['vkt2_soratra'];
          final String? aleloia = item['aleloia'];
          final String evanjely = item['evanjely'];
          final String evanjelySoratra = item['evanjely_soratra'];
          final String? ranombavaka = item['ranombavaka'];
          final String? ranombavakaFiv = item['ranombavaka_fiv'];
          final String? ranombavakaSoratra = item['ranombavaka_soratra'];
          final String? ranombavakaPretra = item['ranombavaka_pretra'];
          final String? vavakaFanolorana = item['vavaka_fanolorana'];
          final String? komonio = item['komonio'];
          final String? vavakaKomonio = item['vavaka_komonio'];

          return Card(
            margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
            color: primary,
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: _getColorFromName(loko),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                height: 24,
                width: 24,
              ),
              title: Text(
                datyGasy,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: secondary,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                '$herinAndro $vanimPotoana',
                style: const TextStyle(
                  color: tertiary,
                  fontSize: 15.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VotoatinySoronaMasina(
                      idSoronaMasina: idSoronaMasina,
                      datyGasy: datyGasy,
                      herinAndro: herinAndro,
                      vanimPotoana: vanimPotoana,
                      taona: taona,
                      tononkira: tononkira,
                      fangatahana: fangatahana,
                      vk1: vk1,
                      vk1Soratra: vk1Soratra,
                      salamo: salamo,
                      salamoSoratra: salamoSoratra,
                      vk2: vk2,
                      vk2Soratra: vk2Soratra,
                      aleloia: aleloia,
                      evanjely: evanjely,
                      evanjelySoratra: evanjelySoratra,
                      ranombavaka: ranombavaka,
                      ranombavakaFiv: ranombavakaFiv,
                      ranombavakaSoratra: ranombavakaSoratra,
                      ranombavakaPretra: ranombavakaPretra,
                      vavakaFanolorana: vavakaFanolorana,
                      komonio: komonio,
                      vavakaKomonio: vavakaKomonio,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
