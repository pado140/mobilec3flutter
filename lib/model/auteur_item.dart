import 'package:flutter_app_c3_mobile/model/book_item.dart';

class AuteurItem {
  int id;
  String name, status, bio, imagepath;
  List<BookItem> books = [];

  AuteurItem.withNames({
    required this.id,
    required this.bio,
    required this.imagepath,
    required this.name,
    required this.status,
  });

  @override
  String toString() {
    return this.name;
  }

  factory AuteurItem.fromJson(Map<String, dynamic> json) {
    AuteurItem ai = AuteurItem.withNames(
        id: int.parse(json["a_id"]),
        name: json["a_title"],
        imagepath: json["a_image"],
        bio: json["a_bio"],
        status: json['a_status']);
    return ai;
  }
}
