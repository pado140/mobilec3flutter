import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/services/cart_services.dart';
import 'package:flutter_app_c3_mobile/ui/items/cart_item_view.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

double calcultotal() {
  double total = 0;
  Cart.items.forEach((element) {
    total += element.qty * element.item.price;
  });
  return total;
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 2,
            );
          },
          itemCount: Cart.items.length,
          itemBuilder: (context, index) {
            return Dismissible(
              onDismissed: (direction) {
                setState(() {
                  Cart.items.remove(Cart.items[index]);
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('item dismissed')));
              },
              background: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Spacer(),
                    Icon(
                      Icons.delete,
                    ),
                  ],
                ),
                color: Colors.orange,
              ),
              key: Key("${Cart.items[index].item.id}"),
              child: CartItemView(
                Cart.items[index],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: size.width,
        height: 100,
        child: Container(
          color: Colors.amber,
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text("Total:"),
                      Text("${calcultotal()}"),
                    ],
                  ),
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            showBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                width: size.width,
                                height: 500,
                                color: Colors.amber,
                              ),
                            );
                          },
                          child: Text("Poursuivre"),
                          style: TextButton.styleFrom()))
                ],
              ),
            ],
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     child: ListView.builder(
      //       scrollDirection: Axis.vertical,
      //       itemBuilder: (context, index) {
      //         return CartItemView(Cart.items[index]);
      //       },
      //     ),
      //   ),
      // ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Mon chariot",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
              Cart.items.length > 0
                  ? "${Cart.items.length} livre ${Cart.items.length > 1 ? 's' : ''}"
                  : "vide",
              style: Theme.of(context).textTheme.caption)
        ],
      ),
      centerTitle: true,
    );
  }
}
