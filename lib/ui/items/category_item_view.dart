import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/model/category_item.dart';
import 'package:flutter_app_c3_mobile/ui/book_by_category.dart';

class CategoryItemView extends StatelessWidget {
  final CategoryItem category;
  const CategoryItemView({Key? key, required this.category}) : super(key: key);

  get _category => category;

  // set _cat(CategoryItem c) => category = c;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: Key("${category.id}"),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return BookByCategory(cat: category);
          },
        ));
      },
      child: Text(category.name),
    );
  }
}
