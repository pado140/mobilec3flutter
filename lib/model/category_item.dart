class CategoryItem {
  final int id;
  final String name;

  CategoryItem({required this.id, required this.name});

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: int.parse(json['cat_id']),
      name: json['cat_name'] as String,
    );
  }
}
