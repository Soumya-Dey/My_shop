import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/user_list_item.dart';
import '../providers/products.dart';
import './edit_products_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "/user_products_screeen";

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.playlist_add),
            onPressed: () => Navigator.of(context).pushNamed(
              EditProductsScreen.routeName,
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: productsData.items.length,
        itemBuilder: (_, index) => UserListItem(
          title: productsData.items[index].title,
          imageUrl: productsData.items[index].imageUrl,
        ),
      ),
    );
  }
}
