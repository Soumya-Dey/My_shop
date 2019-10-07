import 'package:flutter/material.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    this.amount,
    this.dateTime,
    this.id,
    this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    // using insert instead of add method as we need to add
    // new orders as the first element of the list.
    _orders.insert(
      0,
      OrderItem(
        amount: total,
        dateTime: DateTime.now(),
        id: DateTime.now().toString(),
        products: cartProducts,
      ),
    );

    notifyListeners();
  }
}
