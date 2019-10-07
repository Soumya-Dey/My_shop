import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/cart.dart';
import './cart_icon.dart';
import './price_icon.dart';

class ProductDetail extends StatelessWidget {
  final String productId;

  ProductDetail(this.productId);

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(
      context,
      listen: false,
    );
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
      // listen: false ensures that this widget doesn't rebuild
      // even if the Products class changes
    ).findById(productId);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 250,
            child: Image.network(
              loadedProduct.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              loadedProduct.title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              loadedProduct.description,
              style: Theme.of(context).textTheme.headline.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: PriceIcon(loadedProduct.price),
          ),
          SizedBox(
            height: 20,
          ),
          Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: CartIcon(),
                ),
                onTap: () {
                  cartData.addItem(
                    loadedProduct.id,
                    loadedProduct.title,
                    loadedProduct.price,
                    loadedProduct.imageUrl,
                  );

                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Added item to cart"),
                      backgroundColor: Colors.black,
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: "UNDO",
                        onPressed: () => cartData.removeSingleItem(
                          loadedProduct.id,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
