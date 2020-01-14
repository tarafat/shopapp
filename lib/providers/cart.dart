import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartItem {
  String productId;
  String title;
  double price;
  int quantity;

  CartItem({
    @required this.productId,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cart = {};

  Map<String, CartItem> get cart {
    return {..._cart};
  }

  int get itemCount {
    return _cart.length;
  }

  double get totalAmmount {
    double amount = 0.0;
    _cart.forEach((key, cartItem) {
      amount += cartItem.quantity * cartItem.price;
    });
    return amount;
  }

  void addItem(String productid, double price, String title) {
    if (_cart.containsKey(productid)) {
      _cart.update(
        productid,
        (existingItem) => CartItem(
          productId: existingItem.productId,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _cart.putIfAbsent(
        productid,
        () => CartItem(
          productId: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productid) {
    _cart.remove(productid);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_cart.containsKey(productId)) {
      return;
    }
    if (_cart[productId].quantity > 1) {
      _cart.update(
        productId,
        (i) => CartItem(
            productId: i.productId,
            price: i.price,
            title: i.title,
            quantity: i.quantity - 1),
      );
    }else{
      _cart.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _cart = {};
    notifyListeners();
  }
}
