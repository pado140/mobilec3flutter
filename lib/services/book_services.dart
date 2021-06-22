import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/model/book_item.dart';
import 'package:flutter_app_c3_mobile/services/api_services.dart';
import 'package:http/http.dart' as http;

class BookServices {
  Future<List<BookItem>> fetchBooks(Map<String, dynamic>? critere) async {
    List<BookItem> listbook = [];
    String q = "user_id=53";
    if (critere!.isNotEmpty) {
      critere.forEach((key, value) {
        q += "&$key=$value";
      });
    }
    print("executed");
    final response = await http.get(
      Uri(
        scheme: scheme,
        host: authority,
        path: base_path + "booklist2",
        query: q,
      ),
    );
    if (response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      Map<String, dynamic> values = json.decode(response.body);
      if (values.isNotEmpty) {
        if (values["status"] == 200) {
          // print(values["Result"]);
          List<dynamic> vals = values["Result"];
          List<Map<String, dynamic>> valeurs =
              vals.map((e) => e as Map<String, dynamic>).toList();
          for (var i = 0; i < valeurs.length; i++) {
            BookItem b = BookItem.fromJson(valeurs[i]);
            listbook.add(b);
          }
          // CategoryItem cat=CategoryItem(id: , name: name)
        }
      }
      return listbook;
    } else {
      // If the response was umexpected, throw an error.
      Dialog(
        child: Text("fail to load"),
      );
      throw Exception('Failed to load book');
    }
  }
}
