import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String imageUrl;

  CartItem({
    @required this.id,
    @required this.productId,
    @required this.price,
    @required this.quantity,
    @required this.title,
    @required this.imageUrl,
  });

  Widget showItem({
    imageUrl,
    title,
    quantity,
    price,
    BuildContext context,
    increaseQ,
    decreaseQ,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
        right: 16,
        left: 16,
      ),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.black12,
        //   width: 3,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 2,
            blurRadius: 3,
          ),
        ],
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 100,
            padding: EdgeInsets.fromLTRB(9, 2, 0, 2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "₹$price",
                style: TextStyle(
                  color: Color.fromRGBO(200, 200, 200, 1),
                ),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () => increaseQ(
                    productId,
                    title,
                    price,
                    imageUrl,
                  ),
                ),
                Text(
                  "Qty: $quantity",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () => decreaseQ(
                    productId,
                    context,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context, listen: false);

    return Dismissible(
      key: ValueKey(id),
      background: Container(
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        padding: EdgeInsets.only(
          right: 20,
        ),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              "Are you sure?",
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.black,
                  ),
            ),
            content: Text("This will remove the item from the cart."),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "NO",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => Navigator.of(ctx).pop(false),
              ),
              FlatButton(
                child: Text(
                  "YES",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => Navigator.of(ctx).pop(true),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        cartData.removeItem(productId);
      },
      child: showItem(
        imageUrl: imageUrl,
        price: price,
        quantity: quantity,
        title: title,
        context: context,
        increaseQ: cartData.addItem,
        decreaseQ: cartData.decreaseQuantity,
      ),
    );
  }
}
