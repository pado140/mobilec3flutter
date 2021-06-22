import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/model/auteur_item.dart';
import 'package:flutter_app_c3_mobile/model/book_item.dart';
import 'package:flutter_app_c3_mobile/services/api_services.dart';
import 'package:flutter_app_c3_mobile/services/cart_services.dart';
import 'package:flutter_app_c3_mobile/ui/author_view.dart';
import 'package:flutter_app_c3_mobile/ui/cart_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({Key? key}) : super(key: key);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

String _authors_to_string(List<AuteurItem> au) {
  return au.join(",");
}

class _BookDetailsState extends State<BookDetails> {
  int? maxlines = 5;
  String expandtext = "voir plus...";

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)!.settings.arguments as BookItem;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: true,
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.black54,
        title: Text(
          "Détails Livres",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        actions: [
          Container(
            child: Stack(children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return CartView();
                    }),
                  );
                },
                icon: Icon(
                  Icons.shopping_cart,
                  size: 35,
                ),
              ),
              Positioned(
                left: 20,
                top: 12,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  child: Text(
                    "${Cart.items.length}",
                    style: TextStyle(color: Colors.amber.shade700),
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              width: size.width,
              child: Column(
                children: [
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 110,
                        child: Image.network(
                          "$scheme://$authority/${book.imgpath}",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: size.width - 130,
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 10, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    book.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  child: Text(
                                    _authors_to_string(book.auteurs),
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(color: Colors.blue.shade200),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) {
                                            return AuthorView();
                                          },
                                          settings: RouteSettings(
                                            name: "author book",
                                            arguments: book.auteurs[0],
                                          )),
                                    );
                                  },
                                ),
                                RatingBarIndicator(
                                  itemSize: 18,
                                  rating: book.rating,
                                  itemBuilder: (context, index) => Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.amber),
                                ),
                                Text(
                                  "${book.price} HTG",
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            right: -7,
                            child: Icon(
                              Icons.bookmark_outline_rounded,
                              size: 34,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(
                            left: 40,
                            right: 40,
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black87),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => {
                          addItemcart(
                              CartItem(
                                qty: 1,
                                price: book.price,
                                item: book,
                              ),
                              context),
                          setState(
                            () => {
                              0,
                            },
                          )
                        },
                        child: Text(
                          "Ajouter au panier",
                          style: TextStyle(color: Colors.indigo),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            padding: EdgeInsets.only(left: 65, right: 65),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () => {},
                        child: Text("Acheter"),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description:",
                    textAlign: TextAlign.left,
                    textScaleFactor: 1.2,
                  ),
                  Text.rich(
                    TextSpan(
                      text: book.description,
                    ),
                    maxLines: maxlines,
                    overflow: TextOverflow.fade,
                  ),
                  GestureDetector(
                    child: Text(
                      expandtext,
                      style: TextStyle(color: Colors.blue.shade400),
                    ),
                    onTap: () {
                      setState(() {
                        if (maxlines == null) {
                          maxlines = 5;
                          expandtext = "voir plus...";
                        } else {
                          maxlines = null;
                          expandtext = "voir moins...";
                        }
                      });
                    },
                  ),
                  Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
