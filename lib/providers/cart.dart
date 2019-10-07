import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String imageUrl;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.quantity,
    @required this.title,
    @required this.imageUrl,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
    // returning a copy of all items
  }

  int get itemCount {
    // return _items.length;
    var totalCount = 0;
    _items.forEach(
      (key, cartItem) => totalCount += cartItem.quantity,
    );

    return totalCount;
  }

  String get totalPrice {
    var totalPrice = 0.0;
    _items.forEach(
      (key, cartItem) => totalPrice += cartItem.price * cartItem.quantity,
    );
    String totalPriceString = totalPrice.toStringAsFixed(2);

    return totalPriceString;
  }

  void addItem(
    String prodId,
    String title,
    double price,
    String imageUrl,
  ) {
    // increase quantity by 1 if the item already exists
    if (_items.containsKey(prodId)) {
      _items.update(
        prodId,
        (existingItem) => CartItem(
          id: existingItem.id,
          price: existingItem.price,
          title: existingItem.title,
          quantity: existingItem.quantity + 1,
          imageUrl: existingItem.imageUrl,
        ),
      );
      // add a product for 1st time if it doesn't exist before
    } else {
      _items.putIfAbsent(
        prodId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          title: title,
          quantity: 1,
          imageUrl: imageUrl,
        ),
      );
    }

    notifyListeners();
    // notify the listeners that data has been changed
  }

  void decreaseQuantity(String productId, BuildContext context) {
    _items.update(
      productId,
      (existingItem) => CartItem(
        id: existingItem.id,
        price: existingItem.price,
        title: existingItem.title,
        quantity: existingItem.quantity > 1
            ? existingItem.quantity - 1
            : Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Opps! Quantity can't be less than 1"),
                  backgroundColor: Colors.black,
                ),
              ),
        imageUrl: existingItem.imageUrl,
      ),
    );

    notifyListeners();
    // notify the listeners that data has been changed
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          price: existingItem.price,
          title: existingItem.title,
          quantity: existingItem.quantity - 1,
          imageUrl: existingItem.imageUrl,
        ),
      );
    } else {
      _items.remove(productId);
    }

    notifyListeners();
    // notify the listeners that data has been changed
  }

  void removeItem(String productId) {
    _items.remove(productId);

    notifyListeners();
  }

  void clearCart() {
    _items = {};

    notifyListeners();
  }
}
