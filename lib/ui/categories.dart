import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/model/category_item.dart';
import 'package:flutter_app_c3_mobile/services/cat_services.dart';

import 'items/category_item_view.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  CatServices cat = CatServices();
  late Future<List<CategoryItem>> catlist = cat.fetchCategories();

  @override
  void initState() {
    catlist = cat.fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // margin: EdgeInsets.only(
      //   top: 10,
      // ),
      width: size.width,
      height: 93,
      // color: Colors.black,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "Categories",
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
                    onPressed: () {},
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
            height: 35,
            child: FutureBuilder<List<CategoryItem>>(
              future: catlist,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        key: Key("${snapshot.data![index].id}"),
                        margin: EdgeInsets.only(
                            left: 10, right: index == 9 ? 10 : 0),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CategoryItemView(
                          category: snapshot.data![index],
                        ),
                      );
                    },
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                  );
                }
                if (snapshot.hasError) {
                  return Text("Aucune donnees trouve");
                } else
                  return Text("Erreur");
              },
            ),
          )
        ],
      ),
    );
  }
}
