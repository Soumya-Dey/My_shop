import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    );
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        header: Container(
          margin: const EdgeInsets.all(8),
          child: HeaderForItems(),
        ),
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: product.id, // pushing the id of the selected product
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            //textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline.copyWith(
                  color: Colors.white,
                ),
          ),
          //subtitle: Text("${product.price}"),
          trailing: Tooltip(
            message: "Add to cart",
            verticalOffset: 30,
            child: IconButton(
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  cart.addItem(
                    product.id,
                    product.title,
                    product.price,
                    product.imageUrl,
                  );

                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Added item to cart"),
                      backgroundColor: Colors.black,
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: "UNDO",
                        onPressed: () => cart.removeSingleItem(product.id),
                      ),
                    ),
                  );
                  //print(cart.itemCount);
                }),
          ),
        ),
      ),
    );
  }
}

class HeaderForItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: Colors.black87,
            child: Tooltip(
              message: "Add to wishlist",
              verticalOffset: 30,
              child: Consumer<Product>(
                // only rebuilding the icon button when isFavorite changes.
                // if Provider.of(context) is used instead of Consumer()
                // then it would have rebuilt the whole widget whenever
                // isFavorite is changed.
                builder: (_, product, child) => IconButton(
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    product.toggleFavorite();
                    // print(product.title + " ${product.isFavorite}");
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
