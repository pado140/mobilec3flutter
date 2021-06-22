import 'package:flutter_app_c3_mobile/model/auteur_item.dart';
import 'package:flutter_app_c3_mobile/model/category_item.dart';

class BookItem {
  String isbn, description, imgpath, url, status, title;
  int id;
  double price, rating = 0;
  bool paid = false, feature = false;
  late CategoryItem category;
  late List<AuteurItem> auteurs = [];

  BookItem(
      {this.isbn = "",
      this.description = "",
      this.imgpath = "",
      this.id = 0,
      this.url = "",
      this.title = "",
      this.feature = false,
      CategoryItem? cat,
      List<AuteurItem>? auteurs,
      this.paid = false,
      this.price = 0,
      this.rating = 0,
      this.status = ""});

  _category(CategoryItem c) {
    this.category = c;
  }

  _auteurs(AuteurItem a) => this.auteurs.add(a);

  factory BookItem.fromJson(Map<String, dynamic> json) {
    BookItem b = BookItem(
      id: int.parse(json["b_id"]),
      title: json["b_title"],
      imgpath: json["b_image"],
      // isbn: json["ISBN"],
      price: double.parse(json["b_price"]),
      description: json['b_description'],
      url: json["b_url"],
      rating: double.parse(json["avg_rating"]),
    );
    if (json['authors'] != null) {
      List<dynamic> vals = json['authors'];
      List<Map<String, dynamic>> aut = vals
          .map(
            (e) => e as Map<String, dynamic>,
          )
          .toList();

      aut.forEach(
        (aut) {
          b._auteurs(
            AuteurItem.withNames(
              id: int.parse(aut['a_id']),
              bio: aut['a_bio'],
              imagepath: aut['a_image'],
              name: aut['a_title'],
              status: aut['a_status'],
            ),
          );
        },
      );
    }

    b._category(
        CategoryItem(id: int.parse(json['cat_id']), name: json["cat_name"]));
    return b;
  }
}
