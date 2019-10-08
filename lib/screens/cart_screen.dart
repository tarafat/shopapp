import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item.dart';
import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/Cart-Screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            elevation: 2.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Chip(
                  label: Text('\$${cart.totalAmmount.toStringAsFixed(2)}',
                      style: Theme.of(context).primaryTextTheme.title),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                FlatButton(
                  child: Text(
                    'Confirm Order',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    Provider.of<Orders>(context,listen: false).addOrder(
                      cart.cart.values.toList(),
                      cart.totalAmmount,
                    );
                    cart.clear();
                  },
                )
              ],
            ),
          ),
          SizedBox(),
          Expanded(
            child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (ctx, i) => CartItem(
                    cart.cart.values.toList()[i].productId,
                    cart.cart.keys.toList()[i],
                    cart.cart.values.toList()[i].price,
                    cart.cart.values.toList()[i].quantity,
                    cart.cart.values.toList()[i].title)),
          )
        ],
      ),
    );
  }
}
