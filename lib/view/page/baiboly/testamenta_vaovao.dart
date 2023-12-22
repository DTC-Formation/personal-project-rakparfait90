import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/view/page/baiboly/tokopage.dart';

class TestamentaVaovao extends StatelessWidget {
  const TestamentaVaovao({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: secondary,
        title: const Text(
          'Testamenta vaovao',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Lisitry ny boky rehetra
        future: DatabaseHelper().getBoky("Testamenta vaovao"),
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
            // Ireo testamenta vaovao
            final books = snapshot.data!;
            // print(books);
            return Column(
              children: [
                Container(
                  color: secondary,
                  alignment: Alignment.center,
                  width: size.width,
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    "Ny testamenta vaovao dia misy boky 27 no mandrafitra azy: \nNy Evanjely 4 [Matio - Marka - Lioka - Joany]",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: books.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        borderOnForeground: true,
                        margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                        color: Colors.white,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: Image.asset(
                              'assets/images/icons/baiboly.png',
                              height: 48),
                          title: Text(
                            books.elementAt(index)['boky'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            books.elementAt(index)['fanononanaBoky'],
                            style: const TextStyle(fontSize: 14),
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
