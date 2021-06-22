import 'dart:convert';

import 'package:flutter_app_c3_mobile/model/category_item.dart';
import 'package:flutter_app_c3_mobile/services/api_services.dart';
import 'package:http/http.dart' as http;

class CatServices {
  List<CategoryItem> listcategory = [];
  Future<List<CategoryItem>> fetchCategories() async {
    final response = await http.get(Uri(
        scheme: "https", host: authority, path: base_path + "categorylist"));

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
            CategoryItem cat = CategoryItem.fromJson(valeurs[i]);
            listcategory.add(cat);
          }
          // CategoryItem cat=CategoryItem(id: , name: name)
        }
      }
      return listcategory;
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
