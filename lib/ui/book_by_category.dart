import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/model/book_item.dart';
import 'package:flutter_app_c3_mobile/model/category_item.dart';
import 'package:flutter_app_c3_mobile/services/book_services.dart';

import 'items/book_item_view copy.dart';

class BookByCategory extends StatefulWidget {
  final CategoryItem cat;
  const BookByCategory({Key? key, required this.cat}) : super(key: key);

  @override
  _BookByCategoryState createState() => _BookByCategoryState();
}

class _BookByCategoryState extends State<BookByCategory> {
  BookServices bk = BookServices();
  Future<List<BookItem>>? booklist, bookfilter;
  Widget customHeaderApp = Text("Les Livres");
  bool issearch = false;
  Icon customsearchIcon = Icon(Icons.search_rounded);
  @override
  void initState() {
    super.initState();
    booklist = bk.fetchBooks({"cat_id": widget.cat.id});
    bookfilter = booklist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customHeaderApp,
        backgroundColor: Colors.amber.shade700,
        actions: [
          IconButton(
              onPressed: () {
                if (!issearch) {
                  setState(() {
                    issearch = true;
                    customHeaderApp = TextField(
                      showCursor: true,
                      decoration:
                          InputDecoration(hintText: "Recherche livre ..."),
                      onChanged: (data) {
                        setState(() {
                          bookfilter = booklist!.then((value) async => value
                              .where((element) => element.title.contains(data))
                              .toList());
                        });

                        // Future.sync(() => null)
                      },
                    );
                    customsearchIcon = Icon(Icons.cancel_outlined);
                  });
                } else {
                  setState(() {
                    customHeaderApp = Text("Auteurs");
                    issearch = false;
                    customsearchIcon = Icon(Icons.search_rounded);
                  });
                }
              },
              icon: customsearchIcon)
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: FutureBuilder<List<BookItem>>(
          future: bookfilter,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 30,
                    childAspectRatio: 0.6),
                itemBuilder: (context, index) {
                  return Container(
                    key: Key("${snapshot.data![index].id}"),
                    child: BookItemView(
                      book: snapshot.data![index],
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.vertical,
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text("Aucune donnees trouve");
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
