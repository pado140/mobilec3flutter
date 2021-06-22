import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/model/book_item.dart';
import 'package:flutter_app_c3_mobile/services/api_services.dart';
import 'package:flutter_app_c3_mobile/services/cart_services.dart';
import 'package:flutter_app_c3_mobile/ui/book_details.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookItemView extends StatelessWidget {
  final BookItem book;
  const BookItemView({Key? key, required this.book}) : super(key: key);

  get _book => book;

  // set _cat(CategoryItem c) => category = c;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 230,
        width: 100,
        child: GestureDetector(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 150,
                child: Stack(
                  children: [
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
                          addItemcart(
                              CartItem(
                                qty: 1,
                                price: book.price,
                                item: book,
                              ),
                              context);
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
              Container(
                  width: 100,
                  child: RatingBarIndicator(
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber.shade700,
                    ),
                    itemSize: 18,
                    rating: book.rating,
                    direction: Axis.horizontal,
                  ))
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
