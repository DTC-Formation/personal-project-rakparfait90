import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/view/page/fihirana/header.dart';
import 'package:katolika/view/page/fihirana/tononkira.dart';

class LisitraHira extends StatefulWidget {
  final int fihiranaId;
  final String fihiranaName;
  final String fihiranaSubtitle;

  const LisitraHira({
    required this.fihiranaId,
    required this.fihiranaName,
    required this.fihiranaSubtitle,
    super.key,
  });

  @override
  State<LisitraHira> createState() => _LisitraHiraState();
}

class _LisitraHiraState extends State<LisitraHira> {
  int? _searchedPage;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: const HeaderFihirana(),
      body: Column(
        children: [
          //container fihirana
          Container(
            color: secondary,
            width: size.width,
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              widget.fihiranaName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //container subtitle fihirana
          Container(
            color: secondary,
            width: size.width,
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Text(
              widget.fihiranaSubtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          // Champ de saisie de texte et bouton de recherche
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Pejy tadiavina...',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _searchedPage = int.tryParse(value);
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
            future: DatabaseHelper().getLohatenyByFihiranaId(widget.fihiranaId,
                pejy: _searchedPage),
            builder: (context, lohatenySnapshot) {
              if (lohatenySnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (lohatenySnapshot.hasError) {
                return Center(
                  child: Text('Error: ${lohatenySnapshot.error}'),
                );
              } else {
                List<Map<String, dynamic>> lohatenyList =
                    lohatenySnapshot.data ?? [];
                //Container liste lohateny hira et pejy
                return Expanded(
                  child: ListView.builder(
                    itemCount: lohatenyList.length,
                    itemBuilder: (context, index) {
                      final hiraId = lohatenyList.elementAt(index)['id'] as int;
                      final lohatenyHira =
                          lohatenyList.elementAt(index)['lohateny'] as String;
                      final pejy = lohatenyList.elementAt(index)['pejy'] as int;
                      final tononkira =
                          lohatenyList.elementAt(index)['tononkira'] as String;

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
                              "${widget.fihiranaName} - pejy: $pejy",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      FadeTransition(
                                    opacity: animation,
                                    child: TononkiraScreen(
                                      hiraId: hiraId,
                                      hiraLohateny: lohatenyHira,
                                      tononkira: tononkira,
                                    ),
                                  ),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
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
