import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_grid.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';

enum Filters {
  Favorites,
  All,
}

Widget _popupItem(IconData icon, String label) {
  return Row(
    children: <Widget>[
      Icon(
        icon,
      ),
      SizedBox(
        width: 8,
      ),
      Text(
        label,
      ),
    ],
  );
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoritesOnly = false;

  Widget get appBar {
    return AppBar(
      title: Text("MyShop"),
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
        PopupMenuButton(
          icon: Icon(
            Icons.more_vert,
          ),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: _popupItem(
                Icons.favorite_border,
                "Only Favorites",
              ),
              value: Filters.Favorites,
            ),
            PopupMenuItem(
              child: _popupItem(
                Icons.select_all,
                "Show All",
              ),
              value: Filters.All,
            ),
          ],
          onSelected: (Filters selectedValue) {
            setState(() {
              if (selectedValue == Filters.Favorites)
                _showFavoritesOnly = true;
              else
                _showFavoritesOnly = false;
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavoritesOnly),
    );
  }
}
