import 'package:flutter/material.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/view/page/fihirana/header.dart';
import 'package:katolika/view/page/fihirana/lisitrahira.dart';

class LisitraFihirana extends StatelessWidget {
  const LisitraFihirana({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lighten_3,
      appBar: const HeaderFihirana(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper().getFihirana(null),
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
            final fihirana = snapshot.data!;
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: fihirana.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      int fihiranaId = fihirana.elementAt(index)['id'];
                      String fihiranaName =
                          fihirana.elementAt(index)['fihirana'];
                      String fihiranaSubtitle =
                          fihirana.elementAt(index)['fihirana_subtitle'];
                      return Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        margin: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                        decoration: BoxDecoration(
                          color: primary,
                          border: Border.all(
                            color: tertiary,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  fihiranaName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  fihiranaSubtitle,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    color: tertiary,
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
                                        child: LisitraHira(
                                          fihiranaId: fihiranaId,
                                          fihiranaName: fihiranaName,
                                          fihiranaSubtitle: fihiranaSubtitle,
                                        ),
                                      ),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                              ),
                            ),
                            FutureBuilder<int>(
                              future: DatabaseHelper().countHira(
                                  "${fihirana.elementAt(index)['id']}"),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "${snapshot.data!}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
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
