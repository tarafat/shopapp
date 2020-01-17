import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _item = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // var _showFavouriteOnly = false;

  List<Product> get item {
    // if (_showFavouriteOnly) {
    //   return _item.where((i) => i.isFavourite).toList();
    // }
    return [..._item];
  }

  Product findById(String id) {
    return item.firstWhere((item) => item.id == id);
  }

  List<Product> get showFavourite {
    print('showFavourite Called');
    return _item.where((i) => i.isFavourite).toList();
  }

  // void showFavouriteOnly(){
  //   _showFavouriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll(){
  //   _showFavouriteOnly = false;
  //   notifyListeners();
  // }

  Future<void> addProduct(Product product) {
    const url = "https://shop-app-bde36.firebaseio.com/products.json";
    return http
        .post(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavourite': product.isFavourite,
      }),
    )
        .then((response) {
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _item.add(newProduct);
      notifyListeners();
    }).catchError((error){
      throw error;
    });
  }

  void updateProduct(String id, Product updatedProduct) {
    final prodIndex = _item.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _item[prodIndex] = updatedProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _item.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
