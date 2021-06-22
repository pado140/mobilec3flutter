import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/model/book_item.dart';
import 'package:flutter_app_c3_mobile/services/book_services.dart';
import 'package:flutter_app_c3_mobile/ui/books_all.dart';
import 'package:flutter_app_c3_mobile/ui/items/book_item_view.dart';

class BooksView extends StatefulWidget {
  // static const List<String> srcs=["https://www.c3editions.com/sites/default/files/styles/manual_crop_640_672/public/slider%20welcome%20mobile.jpg","b"];
  final String titre;
  final Map<String, dynamic> criteres;
  const BooksView({Key? key, required this.titre, required this.criteres})
      : super(key: key);

  @override
  _BooksViewState createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  BookServices bk = BookServices();
  late Future<List<BookItem>> booklist = bk.fetchBooks({});

  // @override
  // void initState() {
  //   super.initState();
  //   booklist = bk.fetchBooks();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 250,
      width: size.width,
      // color: Colors.black,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    widget.titre,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return BooksAll();
                        }),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_right_alt,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 200,
            child: FutureBuilder<List<BookItem>>(
              future: booklist,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        key: Key("${snapshot.data![index].id}"),
                        margin: EdgeInsets.only(
                            left: 10, right: index == 9 ? 10 : 0),
                        decoration: BoxDecoration(
                            // border: Border.all(),
                            // borderRadius: BorderRadius.circular(20),
                            ),
                        child: BookItemView(
                          book: snapshot.data![index],
                        ),
                      );
                    },
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                  );
                }
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text("Aucune donnees trouve");
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}
