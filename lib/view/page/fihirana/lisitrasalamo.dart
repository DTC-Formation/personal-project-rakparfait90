import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/view/page/fihirana/header.dart';
import 'package:katolika/view/page/fihirana/tononkira.dart';

class LisitraSalamo extends StatefulWidget {
  const LisitraSalamo({super.key});

  @override
  State<LisitraSalamo> createState() => _LisitraSalamoState();
}

class _LisitraSalamoState extends State<LisitraSalamo> {
  int? _searchedSalamo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: const HeaderFihirana(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Salamo faha- ...',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _searchedSalamo = int.tryParse(value);
                      });
                    },
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {});
                },
              ),
            ],
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: DatabaseHelper().getSalamo(salamoFaha: _searchedSalamo),
            builder: (context, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (dataSnapshot.hasError) {
                return Center(
                  child: Text('Error: ${dataSnapshot.error}'),
                );
              } else {
                List<Map<String, dynamic>> dataList = dataSnapshot.data ?? [];
                //Container liste data hira et pejy
                return Expanded(
                  child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      final hiraId = dataList.elementAt(index)['id'] as int;
                      final salamoFaha =
                          dataList.elementAt(index)['faha'] as int;
                      final lohatenyHira =
                          dataList.elementAt(index)['lohateny'] as String;
                      final fihirana =
                          dataList.elementAt(index)['fihirana'] as String;
                      final pejy = dataList.elementAt(index)['pejy'] as int;
                      final tononkira =
                          dataList.elementAt(index)['tononkira'] as String;

                      return SizedBox(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.lightBlueAccent,
                              width: 1.0,
                            ),
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
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '$salamoFaha',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(6, 0, 4, 0),
                            title: Text(
                              lohatenyHira,
                              style: const TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "$fihirana - pejy: $pejy",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TononkiraScreen(
                                    hiraId: hiraId,
                                    hiraLohateny: lohatenyHira,
                                    tononkira: tononkira,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
