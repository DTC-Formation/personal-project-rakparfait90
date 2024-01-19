import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/view/page/baiboly/tokopage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestamentaTaloha extends StatelessWidget {
  const TestamentaTaloha({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lighten_3,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: primary,
        title: const Text(
          'Testamenta taloha',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Liste des livres dont testamenta = "testamenta taloha"
        future: DatabaseHelper().getBoky("Testamenta taloha"),
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
            final books = snapshot.data!;
            return Column(
              children: [
                Container(
                  color: primary,
                  alignment: Alignment.center,
                  width: size.width,
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    "Ny testamenta taloha dia misy boky 46 no mandrafitra azy: \n- Boky dimin’i Moizy [izay antsoina hoe Torah]",
                    style: TextStyle(
                      color: tertiary,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: books.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                        color: primary,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: SvgPicture.asset(
                            'assets/images/icons/baiboly.svg',
                            color: secondary,
                            height: 48,
                          ),
                          title: Text(
                            books.elementAt(index)['boky'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: secondary,
                              fontSize: 18.0,
                            ),
                          ),
                          subtitle: Text(
                            books.elementAt(index)['fanononanaBoky'],
                            style: const TextStyle(
                              color: tertiary,
                              fontSize: 15.0,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChapterScreen(
                                  bookId: books.elementAt(index)['id'],
                                  bookFanononana:
                                      books.elementAt(index)['fanononanaBoky'],
                                ),
                              ),
                            );
                          },
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
