import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/model/book_item.dart';
import 'package:flutter_app_c3_mobile/services/api_services.dart';
import 'package:flutter_app_c3_mobile/ui/book_details.dart';

class BookItemView extends StatelessWidget {
  final BookItem book;
  const BookItemView({Key? key, required this.book}) : super(key: key);

  get _book => book;

  // set _cat(CategoryItem c) => category = c;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 150,
        width: 100,
        child: GestureDetector(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 150,
                child: Stack(
                  children: [
                    Positioned(
                      child: Icon(Icons.favorite_outline),
                      right: 10,
                      top: 10,
                    ),
                    Positioned.fill(
                      child: Image.network(
                        "$scheme://$authority/${book.imgpath}",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      child: GestureDetector(
                        child: Container(
                          child: Icon(
                            Icons.add_shopping_cart_rounded,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.orange),
                        ),
                        onTap: () {
                          print("favorite");
                        },
                      ),
                      right: 10,
                      bottom: 5,
                    ),
                  ],
                ),
              ),
              Text(
                "${book.title}",
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          onTap: () => {
            print("tap"),
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) {
                    return BookDetails();
                  },
                  settings: RouteSettings(
                    name: "details book",
                    arguments: book,
                  )),
            )
          },
        ),
      ),
    );
  }
}
