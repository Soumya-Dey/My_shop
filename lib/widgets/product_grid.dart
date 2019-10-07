import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final showFavOnly;

  ProductsGrid(this.showFavOnly);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(
      context,
      listen: true,
      // this sets a listener to the parent Provider although listen: true is the default.
    );
    final products =
        showFavOnly ? productData.favoriteItems : productData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (ctx, index) => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 3,
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: ChangeNotifierProvider.value(
          // builder: (ctx) => products[index], // this method is to be used when the widget depends on context.
          value: products[index], // new product is provided each time
          child: ProductItem(),
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5 / 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
    );
  }
}
