import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';
import '../widgets/app_drawer.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart_screen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    Widget priceCard() {
      return Card(
        elevation: 3,
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Chip(
                label: FittedBox(
                  child: Text(
                    "Total:  ₹${cart.totalPrice}",
                  ),
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                labelStyle: Theme.of(context).textTheme.headline.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              FlatButton(
                child: Text(
                  "PLACE ORDER",
                  style: Theme.of(context).textTheme.headline,
                ),
                onPressed: () {
                  Provider.of<Orders>(context, listen: false).addOrder(
                    cart.items.values.toList(),
                    double.parse(cart.totalPrice),
                  );

                  cart.clearCart();
                },
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          priceCard(),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, index) => CartItem(
                id: cart.items.values.toList()[index].id,
                productId: cart.items.keys.toList()[index],
                imageUrl: cart.items.values.toList()[index].imageUrl,
                price: cart.items.values.toList()[index].price,
                quantity: cart.items.values.toList()[index].quantity,
                title: cart.items.values.toList()[index].title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
