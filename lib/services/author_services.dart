import 'dart:convert';

import 'package:flutter_app_c3_mobile/model/auteur_item.dart';
// import 'package:flutter_app_c3_mobile/model/book_item.dart';
import 'package:flutter_app_c3_mobile/services/api_services.dart';
import 'package:http/http.dart' as http;

class AuthorServices {
  Future<List<AuteurItem>> fetchAuthors(Map<String, dynamic>? critere) async {
    List<AuteurItem> listauteurs = [];
    String q = "";
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
        path: base_path + "autherlist",
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
            AuteurItem a = AuteurItem.fromJson(valeurs[i]);
            listauteurs.add(a);
          }
          // CategoryItem cat=CategoryItem(id: , name: name)
        }
      }
      return listauteurs;
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load auteurs');
    }
  }
}
