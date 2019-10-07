import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/product_detail.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product_detail";

  Widget appBar(String productTitle, BuildContext context) {
    return AppBar(
      title: Text(productTitle),
      centerTitle: true,
      elevation: 0,
      actions: <Widget>[
        Consumer<Cart>(
          child: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
          builder: (_, cart, childWidget) => Badge(
            child: childWidget,
            value: cart.itemCount.toString(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // id of the product
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
      // listen: false ensures that this widget doesn't rebuild
      // even if the Products class changes
    ).findById(productId);

    return Scaffold(
      appBar: appBar(loadedProduct.title, context),
      body: ProductDetail(productId),
    );
  }
}
