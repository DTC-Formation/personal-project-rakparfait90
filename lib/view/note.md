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
  Map<int, GlobalKey> itemKeys = {};
  bool isFetchingMore = false;
  bool hasMoreData = true;
  int currentPage = 1;
  DateTime? currentDate;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
    _scrollController.addListener(_scrollListenerForRegularScrolling);
  }

  Future<void> _fetchInitialData({DateTime? selectedDate}) async {
    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

      currentDate = selectedDate;

      var initialItems =
          await DatabaseHelper().getSoronaMasinaByDate(formattedDate);
      if (initialItems.isNotEmpty) {
        setState(() async {
          items = [initialItems.first];
          int dateIndex = await DatabaseHelper().getIndexByDate(formattedDate);
          currentPage = (dateIndex / 30).floor() + 1;
        });
      } else {
        setState(() {
          items.clear();
          currentPage = 1;
          hasMoreData = true;
        });
      }
    } else {
      var initialItems =
          await DatabaseHelper().getSoronaMasina(page: currentPage);
      if (initialItems.isNotEmpty) {
        setState(() {
          items.addAll(initialItems);
          currentPage++;
        });
      }
    }
  }

  Future<void> _fetchSoronaMasinaBeforeDate(String date) async {
    if (isFetchingMore) return;
    setState(() => isFetchingMore = true);
    try {
      List<Map<String, dynamic>> newItems =
          await DatabaseHelper().getSoronaMasinaBeforeDate(date);
      if (newItems.isNotEmpty) {
        setState(() {
          items.insertAll(0, newItems);
          currentDate = DateFormat('yyyy-MM-dd').parse(newItems.first['daty']);
          hasMoreData = newItems.length == 30;
        });
      } else {
        setState(() => hasMoreData = false);
      }
    } catch (e) {
      setState(() => hasMoreData = false);
    }
    setState(() => isFetchingMore = false);
  }

  Future<void> _fetchSoronaMasinaAfterDate(String date) async {
    if (isFetchingMore) return;
    setState(() => isFetchingMore = true);
    try {
      List<Map<String, dynamic>> newItems =
          await DatabaseHelper().getSoronaMasinaAfterDate(date);
      if (newItems.isNotEmpty) {
        setState(() {
          items.addAll(newItems);
          currentDate = DateFormat('yyyy-MM-dd').parse(newItems.last['daty']);
          hasMoreData = newItems.length == 30;
        });
      } else {
        setState(() => hasMoreData = false);
      }
    } catch (e) {
      setState(() => hasMoreData = false);
    }
    setState(() => isFetchingMore = false);
  }

  void _scrollListenerForRegularScrolling() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        hasMoreData) {
      _fetchMoreData();
    }
  }

  void _scrollListenerForCalendarSelection() {
    if (_scrollController.position.atEdge) {
      final isTop = _scrollController.position.pixels == 0;
      if (isTop) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate!);
        _fetchSoronaMasinaBeforeDate(formattedDate);
      } else {
        String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate!);
        _fetchSoronaMasinaAfterDate(formattedDate);
      }
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

  Future<void> _fetchPageData(int page) async {
    setState(() => isFetchingMore = true);

    try {
      var newItems = await DatabaseHelper().getSoronaMasina(page: page);
      if (newItems.isNotEmpty) {
        setState(() {
          items.addAll(newItems);
          currentPage = page;
          hasMoreData = newItems.length == 30;
        });
        if (newItems.isNotEmpty) {
          scrollTo(items.length - newItems.length);
        }
      } else {
        setState(() => hasMoreData = false);
      }
    } catch (e) {
      setState(() => hasMoreData = false);
    }
    setState(() => isFetchingMore = false);
  }

  void scrollTo(int index) {
    final keyContext = itemKeys[index]?.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(keyContext,
          duration: const Duration(milliseconds: 300));
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListenerForRegularScrolling);
    _scrollController.removeListener(_scrollListenerForCalendarSelection);
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
          style: TextStyle(color: lighten_1),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selectedDate != null) {
                setState(() {
                  items.clear();
                  isFetchingMore = false;
                  hasMoreData = true;
                });
                var index = await DatabaseHelper().getIndexByDate(
                  DateFormat('yyyy-MM-dd').format(selectedDate),
                );
                if (index != -1) {
                  int page = (index / 30).floor() + 1;
                  currentPage = page;
                  _fetchPageData(page);
                }
              }
            },
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
          if (!itemKeys.containsKey(index)) {
            itemKeys[index] = GlobalKey();
          }

          var item = items[index];
          var loko = item['loko'];
          return Card(
            margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
            color: primary,
            child: ListTile(
              key: itemKeys[index],
              contentPadding: const EdgeInsets.all(0),
              leading: Container(
                margin: const EdgeInsets.all(8.0),
                color: _getColorFromName(loko),
                height: 24,
                width: 24,
              ),
              title: Text(
                '${formatDate(item['daty'])} ${item['daty_gasy']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: secondary,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                '${capitalizeFirstLetter(item['herinandro'].toString().replaceFirst("HER.", "HERINANDRO"))} ${capitalizeFirstLetter(item['vanimpotoana'])}',
                style: const TextStyle(
                  color: tertiary,
                  fontSize: 15.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const VotoatinySoronaMasina(), // make sure VotoatinySoronaMasina is expecting 'item' as an argument if needed.
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



