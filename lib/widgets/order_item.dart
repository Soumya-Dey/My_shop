import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../providers/orders.dart' as provider;

class OrderItem extends StatefulWidget {
  final provider.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var isExpanded = false;

  Widget get expandedDetails {
    return Container(
      height: min(widget.order.products.length * 20.0 + 50, 180),
      child: ListView.builder(
        itemCount: widget.order.products.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(
            widget.order.products[i].title,
          ),
          subtitle: Text(
            "₹${widget.order.products[i].price}",
          ),
          trailing: Text(
            "Qty: ${widget.order.products[i].quantity}",
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("₹${widget.order.amount}"),
            subtitle: Text(
                DateFormat("dd/MM/yyyy hh:mm").format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ),
          if (isExpanded) expandedDetails,
        ],
      ),
    );
  }
}
