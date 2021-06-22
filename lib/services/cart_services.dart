import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/model/book_item.dart';

class CartItem {
  int id = 0, qty = 01;
  double price = 0.0;
  BookItem item;
  late Cart cart;

  CartItem({int? id, int? qty, required this.price, required this.item}) {
    // this.id = id!;
    // this.qty = qty!;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          item == other.item;

  @override
  int get hashCode => item.hashCode;
}

class Cart {
  int id = 0, userId = 0;
  static List<CartItem> items = List.empty(growable: true);

  Cart({int? id, int? userid}) {
    this.id = id!;
    this.userId = userid!;
  }

  // bool _empty() => items.isEmpty;

  void set addItem(CartItem c) => items.add(c);

  set updateItem(CartItem c) => items.insert(items.indexOf(c), c);

  bool deleteItem(CartItem c) => items.remove(c);
}

void addItemcart(CartItem c, BuildContext context) {
  try {
    Cart.items.contains(c)
        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Livre deja dans le panier"),
          ))
        : Cart.items.add(c);
  } catch (e) {}
}
