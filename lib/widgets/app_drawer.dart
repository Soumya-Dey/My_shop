import 'package:flutter/material.dart';
import 'package:shop_app/screens/user_products_screen.dart';

import '../screens/orders_screen.dart';
import '../screens/cart_screen.dart';

class DrawerTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function tapHandler;

  DrawerTile(
    this.iconData,
    this.title,
    this.tapHandler,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: tapHandler,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: <Widget>[
              Icon(
                iconData,
                size: 32,
                color: Colors.black54,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: "BLinker",
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  Widget drawerHeader(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        Positioned(
          left: 20,
          bottom: 20,
          child: Icon(
            Icons.account_circle,
            size: 48,
            color: Colors.white,
          ),
        ),
        Positioned(
          left: 90,
          bottom: 26,
          child: Text(
            "Hey there!",
            style: Theme.of(context).textTheme.title.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                fontFamily: "Blinker"),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          drawerHeader(context),
          SizedBox(
            height: 8,
          ),
          DrawerTile(
            Icons.shopping_basket,
            "My Shop",
            () => Navigator.of(context).pushReplacementNamed("/"),
          ),
          DrawerTile(
            Icons.edit,
            "Manage Products",
            () => Navigator.of(context).pushNamed(UserProductsScreen.routeName),
          ),
          DrawerTile(
            Icons.shopping_cart,
            "Your Cart",
            () => Navigator.of(context).pushNamed(CartScreen.routeName),
          ),
          DrawerTile(
            Icons.payment,
            "Your Orders",
            () => Navigator.of(context).pushNamed(OrdersScreen.routeName),
          ),
        ],
      ),
    );
  }
}
