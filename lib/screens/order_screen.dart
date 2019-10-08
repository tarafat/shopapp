import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "/orders";
  @override
  Widget build(BuildContext context) {
    final ordersdata = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Ordrs'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersdata.orders.length,
        itemBuilder: (ctx,i) => OrderItem(ordersdata.orders[i]),
      )
    );
  }
}
