import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/cart.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
//import '../providers/products.dart';
import '../screens/cart_screen.dart';

enum Filteroptions {
  Favourite,
  AllItem,
}

class ProductOverViewScreen extends StatefulWidget {
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
    var _isFavourote = false;
  @override
  Widget build(BuildContext context) {
    //var productsContainer = Provider.of<Products>(context);
    //var cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (Filteroptions selectedFilter) {
              setState(() {
                if (selectedFilter == Filteroptions.Favourite) {
                 // print('{$selectedFilter from inside}');
                  _isFavourote = true;
                } else {
                  _isFavourote = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favourite'),
                value: Filteroptions.Favourite,
              ),
              PopupMenuItem(
                child: Text('All Item'),
                value: Filteroptions.AllItem,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ct) => (Badge(
              child: ct,
              value: cart.itemCount.toString(),
              color: Theme.of(context).accentColor,
            )),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_isFavourote),
    );
  }
}
