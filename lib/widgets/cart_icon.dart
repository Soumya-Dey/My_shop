import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.add_shopping_cart,
            color: Colors.white,
          ),
          SizedBox(
            width: 6,
          ),
          Text("Add to cart"),
        ],
      ),
      labelPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      labelStyle: Theme.of(context).textTheme.title,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}