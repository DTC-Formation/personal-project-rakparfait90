import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';
import 'package:katolika/controller/database_helper.dart';
import 'package:katolika/view/page/baiboly/andininymanokana.dart';

class FamakianaManokana extends StatelessWidget {
  const FamakianaManokana({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: AppBar(
        backgroundColor: primaryDark,
        title: const Text(
          'Baiboly Masina',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Lisitry ny boky rehetra
        future: DatabaseHelper().getBoky(null),
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
                    "Toko sy andinin-tSoratra Masina manokana",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    // scrollDirection: Axis.vertical,
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
                          title:
                              Text(books.elementAt(index)['boky'].toString()),
                          subtitle: Text(
                              books.elementAt(index)['testamenta'].toString()),
                          onTap: () {
                            _showDetailsModal(
                              context,
                              books.elementAt(index)['boky'].toString(),
                              books
                                  .elementAt(index)['fanononanaBoky']
                                  .toString(),
                              books.elementAt(index)['id'],
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

  void _showDetailsModal(
      BuildContext context, String bookName, String bookTitle, int bookId) {
    int toko = 0;
    int startAndininy = 0;
    int endAndininy = 0;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Andininy manokana',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    bookTitle,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: const InputDecoration(labelText: 'Toko faha-'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '$bookTitle toko faha firy?';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      toko = int.tryParse(value) ?? 0;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          decoration: const InputDecoration(
                              labelText: 'Andininy faha-'),
                          onChanged: (value) {
                            startAndininy = int.tryParse(value) ?? 0;
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Andininy faha firy?';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          decoration: const InputDecoration(
                              labelText: 'ka hatramin\'ny'),
                          onChanged: (value) {
                            endAndininy = int.tryParse(value) ?? 0;
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Hatramin\'ny andininy faha firy?';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Process data.
                        _handleValidation(
                          context,
                          bookName,
                          bookTitle,
                          toko,
                          startAndininy,
                          endAndininy,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondary,
                    ),
                    child: const Text(
                      'Vakiana',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleValidation(BuildContext context, String bookName,
      String bookTitle, int toko, int startAndininy, int endAndininy) {
    // Hidiana ny modal
    Navigator.pop(context);

    // Sokafana izay adininy nosafidiana manokana
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AndininyManokana(
          bookName: bookName,
          bookTitle: bookTitle,
          toko: toko,
          startAndininy: startAndininy,
          endAndininy: endAndininy,
        ),
      ),
    );
  }
}
