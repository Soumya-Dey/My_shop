import 'package:flutter/material.dart';

class PriceIcon extends StatelessWidget {
  final double productPrice;

  PriceIcon(this.productPrice);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text("₹$productPrice"),
      labelStyle: Theme.of(context).textTheme.title.copyWith(
            fontSize: 20,
          ),
      labelPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}