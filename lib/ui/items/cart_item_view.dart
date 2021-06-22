import 'package:flutter/material.dart';
import 'package:flutter_app_c3_mobile/services/api_services.dart';
import 'package:flutter_app_c3_mobile/services/cart_services.dart';

class CartItemView extends StatefulWidget {
  final CartItem item;
  const CartItemView(this.item, {Key? key}) : super(key: key);

  @override
  _CartItemViewState createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView> {
  int qty = 0;
  double montant = 0.0;
  @override
  Widget build(BuildContext context) {
    montant = widget.item.item.price * widget.item.qty;
    return Row(
      children: [
        SizedBox(
          width: 100,
          height: 150,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: EdgeInsets.all(8),
            child: Image.network(
              "$scheme://$authority/${widget.item.item.imgpath}",
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 130,
          width: MediaQuery.of(context).size.width - 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.item.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                widget.item.item.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Theme.of(context).textTheme.caption,
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    "${widget.item.item.price} HTG",
                    style: TextStyle(
                      color: Colors.amber.shade700,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.item.qty -= 1;
                              if (widget.item.qty == 0) {
                                Cart.items.remove(widget.item);
                              } else {
                                montant =
                                    widget.item.qty * widget.item.item.price;
                              }
                            });
                          },
                          icon: Icon(Icons.arrow_left_rounded),
                        ),
                        Text("${widget.item.qty}"),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.item.qty += 1;
                              montant =
                                  widget.item.qty * widget.item.item.price;
                            });
                          },
                          icon: Icon(
                            Icons.arrow_right_rounded,
                          ),
                        ),
                        Spacer(),
                        Text("$montant HTG"),
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
