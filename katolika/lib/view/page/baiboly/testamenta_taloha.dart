import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/view/page/baiboly/tokopage.dart';

class TestamentaTaloha extends StatelessWidget {
  const TestamentaTaloha({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: tealBlue,
        title: const Text(
          'Testamenta taloha',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Lisitry ny boky rehetra
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
            // Ireo testamenta taloha
            final books = snapshot.data!;
            // print(books);
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Ny testamenta taloha dia misy boky 46 no mandrafitra azy: \n- Boky dimin’i Moizy [izay antsoina hoe Torah]",
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
                        margin: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                        color: Colors.white,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: Image.asset(
                              'assets/images/icons/baiboly.png',
                              height: 48),
                          title: Text(books[index]['boky']),
                          subtitle: Text(books[index]['testamenta']),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChapterScreen(bookId: books[index]['id']),
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
